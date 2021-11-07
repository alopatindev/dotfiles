local actions = require "fzf-lua.actions"
local config = require "fzf-lua.config"
local core = require "fzf-lua.core"
local libuv = require "fzf-lua.libuv"
local path = require "fzf-lua.path"
local utils = require "fzf-lua.utils"
local win = require "fzf-lua.win"

--local function dbg(data)
--  f = io.open("/tmp/dbg.txt", "a+")
--  f:write(vim.inspect(data) .. "\n")
--  f:close()
--end

local function bufname_with_line_key(bufname, line)
  return bufname .. (line and (':' .. line) or '')
end

local function has_bufname_with_line(bufnames_with_lines, bufname, line)
  local key = bufname_with_line_key(bufname, line)
  return bufnames_with_lines[key] == true
end

local function add_bufname_with_line(bufnames_with_lines, bufname, line)
  local key = bufname_with_line_key(bufname, line)
  bufnames_with_lines[key] = true
  return bufnames_with_lines
end

local function make_buffer_entries(opts, bufnrs, tabnr)
  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local element = {
      bufnr = bufnr,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    if tabnr then
      local winid = utils.winid_from_tab_buf(tabnr, bufnr)
      if winid then
        element.info.lnum = vim.api.nvim_win_get_cursor(winid)[1]
        element.info.cnum = vim.api.nvim_win_get_cursor(winid)[2]
      end
    end

    table.insert(buffers, element)
  end
  return buffers
end

local function format_item(bufname, line, column, text, bufname_color_fn)
  local colon = utils.ansi_codes.green(':')
  return string.format("%s%s%s%s",
    bufname_color_fn(#bufname>0 and bufname or "[No Name]"),
    line == nil and '' or ('%s%d'):format(colon, line),
    column == nil and '' or ('%s%d'):format(colon, column),
    text == nil and '' or ('%s %s'):format(colon, text))
end

local function add_buffer_entry(opts, buf, items, bufnames_with_lines)
  local bufname = utils._if(#buf.info.name>0, path.relative(buf.info.name, vim.loop.cwd()), "[No Name]")
  local text = opts._is_grep and vim.api.nvim_buf_get_lines(buf.bufnr, buf.info.lnum - 1, buf.info.lnum, false)[1] or nil
  local line = buf.info.lnum
  local column = nil
  local item_str = format_item(bufname, line, column, text, utils.ansi_codes.yellow)
  table.insert(items, item_str)
  bufnames_with_lines = add_bufname_with_line(bufnames_with_lines, bufname, line)
  return items, bufnames_with_lines
end

local function filter_buffers(opts, unfiltered)
  local curtab_bufnrs = {}
  if opts.current_tab_only then
    local curtab = vim.api.nvim_win_get_tabpage(0)
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(curtab)) do
      local b = vim.api.nvim_win_get_buf(w)
      curtab_bufnrs[b] = true
    end
  end

  local excluded = {}
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      excluded[b] = true
    end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
      excluded[b] = true
    end
    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      excluded[b] = true
    end
    if opts.current_tab_only and not curtab_bufnrs[b] then
      excluded[b] = true
    end
    if opts.no_term_buffers and utils.is_term_buffer(b) then
      excluded[b] = true
    end
    if opts.cwd_only and not path.is_relative(vim.api.nvim_buf_get_name(b), vim.loop.cwd()) then
      excluded[b] = true
    end
    if #vim.api.nvim_buf_get_name(b) == 0 then
      -- TODO: it's boring to support new unsaved tabs
      excluded[b] = true
    end
    return not excluded[b]
  end, unfiltered)

  return bufnrs, excluded
end

local function search_in_tabs(items, bufnames_with_lines, opts)
  local curtab = vim.api.nvim_win_get_tabpage(0)

  opts._tab_to_buf = {}
  opts._list_bufs = function()
    local res = {}
    for _, t in ipairs(vim.api.nvim_list_tabpages()) do
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(t)) do
        local b = vim.api.nvim_win_get_buf(w)
        opts._tab_to_buf[t] = opts._tab_to_buf[t] or {}
        opts._tab_to_buf[t][b] = true
        table.insert(res, b)
      end
    end
    return res
  end

  local filtered, excluded = filter_buffers(opts, opts._list_bufs())
  if not next(filtered) then return end

  -- remove the filtered-out buffers
  for b, _ in pairs(excluded) do
    for _, bufnrs in pairs(opts._tab_to_buf) do
      bufnrs[b] = nil
    end
  end

  for t, bufnrs in pairs(opts._tab_to_buf) do
    local bufnrs_flat = {}
    for b, _ in pairs(bufnrs) do
      table.insert(bufnrs_flat, b)
    end

    opts.sort_lastused = false
    local buffers = make_buffer_entries(opts, bufnrs_flat, t)
    for _, buf in pairs(buffers) do
      items, bufnames_with_lines = add_buffer_entry(opts, buf, items, bufnames_with_lines, true)
    end
  end

  return items, bufnames_with_lines
end

local function buffer_lines(items, bufnames_with_lines, opts)
  opts.no_term_buffers = true
  local buffers = filter_buffers(opts,
    opts.current_buffer_only and { vim.api.nvim_get_current_buf() } or
    vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(buffers) do
    local data = {}
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if vim.api.nvim_buf_is_loaded(bufnr) then
      data = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    elseif vim.fn.filereadable(filepath) ~= 0 then
      data = vim.fn.readfile(filepath, "")
    end
    local bufname = path.relative(filepath, vim.fn.getcwd())
    for line, text in ipairs(data) do
      if #text > 0 and has_bufname_with_line(bufnames_with_lines, bufname, line) == false then
        table.insert(items, format_item(bufname, line, nil, text, utils.ansi_codes.cyan))
        bufnames_with_lines = add_bufname_with_line(bufnames_with_lines, bufname, line)
      end
    end
  end

  return items, bufnames_with_lines
end

local function get_grep_cmd(opts, search_query, no_esc)
  if opts.cmd_fn and type(opts.cmd_fn) == 'function' then
    return opts.cmd_fn(opts, search_query, no_esc)
  end
  if opts.raw_cmd and #opts.raw_cmd>0 then
    return opts.raw_cmd
  end
  local command = nil
  if opts.cmd and #opts.cmd > 0 then
    command = opts.cmd
  elseif vim.fn.executable("rg") == 1 then
    command = string.format("rg %s", opts.rg_opts)
  else
    command = string.format("grep %s", opts.grep_opts)
  end

  -- filename takes precedence over directory
  -- filespec takes precedence over all and doesn't shellescape
  -- this is so user can send a file populating command instead
  local search_path = ''
  if opts.filespec and #opts.filespec>0 then
    search_path = opts.filespec
  elseif opts.filename and #opts.filename>0 then
    search_path = vim.fn.shellescape(opts.filename)
  end

  search_query = search_query or ''
  if not (no_esc or opts.no_esc) then
    search_query = utils.rg_escape(search_query)
  end

  -- do not escape at all
  if not (no_esc == 2 or opts.no_esc == 2) then
    search_query = vim.fn.shellescape(search_query)
  end

  return string.format('%s %s %s', command, search_query, search_path)
end

local function get_lines_from_file(file)
  local t = {}
  for v in file:lines() do
    table.insert(t, v)
  end
  return t
end

local function raw_fzf(contents, items, fzf_cli_args, opts)
  if not coroutine.running() then
    error("please run function in a coroutine")
  end

  if not opts then opts = {} end
  local cwd = opts.fzf_cwd or opts.cwd
  local cmd = opts.fzf_binary or opts.fzf_bin or 'fzf'
  local fifotmpname = vim.fn.tempname()
  local outputtmpname = vim.fn.tempname()

  if fzf_cli_args then cmd = cmd .. " " .. fzf_cli_args end
  if opts.fzf_cli_args then cmd = cmd .. " " .. opts.fzf_cli_args end

  if contents then
    if type(contents) == "string" and #contents>0 then
      cmd = ("%s | %s"):format(contents, cmd)
    else
      cmd = ("%s < %s"):format(cmd, vim.fn.shellescape(fifotmpname))
    end
  end

  cmd = ("%s > %s"):format(cmd, vim.fn.shellescape(outputtmpname))

  local fd, output_pipe = nil, nil
  local finish_called = false
  local write_cb_count = 0

  -- Create the output pipe
  vim.fn.system(("mkfifo %s"):format(vim.fn.shellescape(fifotmpname)))

  local function finish(_)
    -- mark finish if once called
    finish_called = true
    -- close pipe if there are no outstanding writes
    if output_pipe and write_cb_count == 0 then
      output_pipe:close()
      output_pipe = nil
    end
  end

  local function write_cb(data, cb)
    if not output_pipe then return end
    write_cb_count = write_cb_count + 1
    output_pipe:write(data, function(err)
      -- decrement write call count
      write_cb_count = write_cb_count - 1
      -- this will call the user's cb
      if cb then cb(err) end
      if err then
        -- can fail with premature process kill
        finish(2)
      elseif finish_called and write_cb_count == 0 then
        -- 'termopen.on_exit' already called and did not close the
        -- pipe due to write_cb_count>0, since this is the last call
        -- we can close the fzf pipe
        finish(3)
      end
    end)
  end

  -- nvim-fzf compatibility, builds the user callback functions
  -- 1st argument: callback function that adds newline to each write
  -- 2nd argument: callback function thhat writes the data as is
  -- 3rd argument: direct access to the pipe object
  local function usr_write_cb(nl)
    local function end_of_data(usrdata, cb)
      if usrdata == nil then
        if cb then cb(nil) end
        finish(5)
        return true
      end
      return false
    end
    if nl then
      return function(usrdata, cb)
        if not end_of_data(usrdata, cb) then
          write_cb(tostring(usrdata).."\n", cb)
        end
      end
    else
      return function(usrdata, cb)
        if not end_of_data(usrdata, cb) then
          write_cb(usrdata, cb)
        end
      end
    end
  end

  local co = coroutine.running()
  vim.fn.termopen(cmd, {
    cwd = cwd,
    on_exit = function(_, rc, _)
      local f = io.open(outputtmpname)
      local output = get_lines_from_file(f)
      f:close()
      finish(1)
      vim.fn.delete(fifotmpname)
      vim.fn.delete(outputtmpname)
      if #output == 0 then output = nil end
      coroutine.resume(co, output, rc)
    end
  })
  vim.cmd[[set ft=fzf]]
  vim.cmd[[startinsert]]

  if not contents or type(contents) == "string" then
    goto wait_for_fzf
  end

  -- have to open this after there is a reader (termopen)
  -- otherwise this will block
  fd = vim.loop.fs_open(fifotmpname, "w", -1)
  output_pipe = vim.loop.new_pipe(false)
  output_pipe:open(fd)

  for _, item in ipairs(items) do
    write_cb(item .. "\n")
  end

  -- this part runs in the background, when the user has selected, it will
  -- error out, but that doesn't matter so we just break out of the loop.
  if contents then
    if type(contents) == "table" then
      if not vim.tbl_isempty(contents) then
        write_cb(vim.tbl_map(function(x) return x.."\n" end, contents))
      end
      finish(4)
    else
      contents(usr_write_cb(true), usr_write_cb(false), output_pipe)
    end
  end

  ::wait_for_fzf::

  return coroutine.yield()
end

local function fzf(opts, contents)
  -- normalize with globals if not already normalized
  if not opts._normalized then
    opts = config.normalize_opts(opts, {})
  end
  -- setup the fzf window and preview layout
  local fzf_win = win(opts)
  if not fzf_win then return end
  -- instantiate the previewer
  local previewer, preview_opts = nil, nil
  if opts.previewer and type(opts.previewer) == 'string' then
    preview_opts = config.globals.previewers[opts.previewer]
    if not preview_opts then
      utils.warn(("invalid previewer '%s'"):format(opts.previewer))
    end
  elseif opts.previewer and type(opts.previewer) == 'table' then
    preview_opts = opts.previewer
  end
  if preview_opts and type(preview_opts._new) == 'function' then
    previewer = preview_opts._new()(preview_opts, opts, fzf_win)
  elseif preview_opts and type(preview_opts._ctor) == 'function' then
    previewer = preview_opts._ctor()(preview_opts, opts, fzf_win)
  end
  if previewer then
    opts.fzf_opts['--preview'] = previewer:cmdline()
    if type(previewer.preview_window) == 'function' then
      -- do we need to override the preview_window args?
      -- this can happen with the builtin previewer
      -- (1) when using a split we use the previewer as placeholder
      -- (2) we use 'nohidden:right:0' to trigger preview function
      --     calls without displaying the native fzf previewer split
      opts.fzf_opts['--preview-window'] = previewer:preview_window(opts.preview_window)
    end
  end
  opts.fzf_opts["--delimiter"] = vim.fn.shellescape(':')
  opts.fzf_opts["--no-multi"] = ''
  opts.fzf_opts["--tiebreak"] = 'index'

  fzf_win:attach_previewer(previewer)
  fzf_win:create()

  opts._is_grep = opts.rg_opts ~= nil

  -- TODO: add is_grep flag? closure?
  local items = {}
  local bufnames_with_lines = {}
  items, bufnames_with_lines = search_in_tabs(items, bufnames_with_lines, opts)
  if opts._is_grep then
    items, bufnames_with_lines = buffer_lines(items, bufnames_with_lines, opts)
  end

  local selected, exit_code = raw_fzf(contents, items, core.build_fzf_cli(opts),
    { fzf_binary = opts.fzf_bin, fzf_cwd = opts.cwd })
  utils.process_kill(opts._pid)
  fzf_win:check_exit_status(exit_code)
  if fzf_win:autoclose() == nil or fzf_win:autoclose() then
    fzf_win:close()
  end

  opts._is_grep = false
  return selected
end

local function parse_item(item)
  local fields = utils.strsplit(item, ':')
  local bufname = fields[1]
  local line = tonumber(fields[2])
  local column = tonumber(utils.strsplit(fields[3], ' ')[1])
  local text = nil
  --local text = item:sub(item:find(': ') + 2, -1) -- TODO: slow
  return bufname, line, column, text
end

local function open(selected)
  local bufname, line, column, text = parse_item(selected[2])
  bufname = vim.fn.fnameescape(bufname)
  vim.cmd("tab drop " .. bufname)
  if line ~= nil then
    local command = ('norm! %dG'):format(line)
    -- if column ~= nil then
    --   command = ('%s%d|'):format(command, column)
    -- end
    vim.cmd(command)
  end
end


local function fzf_files(opts)
  if not opts then return end

  -- reset git tracking
  opts.diff_files = nil
  if opts.git_icons and not path.is_git_repo(opts.cwd, true) then opts.git_icons = false end

  coroutine.wrap(function ()
    if opts.cwd_only and not opts.cwd then
      opts.cwd = vim.loop.cwd()
    end

    -- if opts.git_icons then
    --   opts.diff_files = get_diff_files(opts)
    -- end

    local has_prefix = opts.file_icons or opts.git_icons or opts.lsp_icons
    if not opts.filespec then
      opts.filespec = utils._if(has_prefix, "{2}", "{1}")
    end

    local selected = fzf(opts, opts.fzf_fn)

    if opts.post_select_cb then
      opts.post_select_cb()
    end

    if not selected then return end

    if #selected > 1 then
      for i = 2, #selected do
        selected[i] = path.entry_to_file(selected[i], opts.cwd).stripped
        if opts.cb_selected then
          local cb_ret = opts.cb_selected(opts, selected[i])
          if cb_ret then selected[i] = cb_ret end
        end
      end
    end

    open(selected)
  end)()
end

function get_files_cmd(opts)
  if opts.raw_cmd and #opts.raw_cmd>0 then
    return opts.raw_cmd
  end
  if opts.cmd and #opts.cmd>0 then
    return opts.cmd
  end
  local command = nil
  if vim.fn.executable("fd") == 1 then
    command = string.format('fd %s', opts.fd_opts)
  else
    POSIX_find_compat(opts.find_opts)
    command = string.format('find -L . %s', opts.find_opts)
  end
  git_ls_files = 'git ls-files --exclude-standard'
  return git_ls_files .. ' && ' .. command
end

function add_space_before_text(item)
  return item:gsub(':([0-9]*):(.*)', ':%1: %2', 1)
end

function relevant_grep(opts)
  opts = config.normalize_opts(opts, config.globals.grep)
  if not opts then return end

  local search = ''
  local no_esc = false
  local command = get_grep_cmd(opts, search, no_esc)

  opts.fzf_fn = libuv.spawn_nvim_fzf_cmd(
    { cmd = command, cwd = opts.cwd, pid_cb = opts._pid_cb })

  fzf_files(opts)
end

function relevant_files(opts)
  opts = config.normalize_opts(opts, config.globals.files)
  if not opts then return end

  local command = get_files_cmd(opts)

  opts.fzf_fn = libuv.spawn_nvim_fzf_cmd(
    { cmd = command, cwd = opts.cwd, pid_cb = opts._pid_cb })

  fzf_files(opts)
end
