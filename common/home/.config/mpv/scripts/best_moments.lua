local mp = require 'mp'
local opt = require 'mp.options'
local utils = require 'mp.utils'

local min_skip = 0.15
local max_skip = 0.45
local min_view_duration = 6
local max_view_duration = 10 * 60

local options = {
  start_normal = true,
  allowed_directories = "",
}

local ready = false
local stats_dir = os.getenv("HOME") .. "/.config/mpv/best_moments/"
local last_pos = 0
local watch_start = 0
local views = {}
local normal_mode = false
local resume_to_best_moments = false
local stats_file = nil
local stats_file = nil
local best_intervals = {}
local interval_index = 1

local sha1 = (function()
local sha1 = {}
-- sha1 implementation from http://cube3d.de/uploads/Main/sha1.txt (MIT license)

-- set this to false if you don't want to build several 64k sized tables when
-- loading this file (takes a while but grants a boost of factor 13)
local cfg_caching = false
-- local storing of global functions (minor speedup)
local floor,modf = math.floor,math.modf
local char,format,rep = string.char,string.format,string.rep

-- merge 4 bytes to an 32 bit word
local function bytes_to_w32 (a,b,c,d) return a*0x1000000+b*0x10000+c*0x100+d end
-- split a 32 bit word into four 8 bit numbers
local function w32_to_bytes (i)
  return floor(i/0x1000000)%0x100,floor(i/0x10000)%0x100,floor(i/0x100)%0x100,i%0x100
end

-- shift the bits of a 32 bit word. Don't use negative values for "bits"
local function w32_rot (bits,a)
  local b2 = 2^(32-bits)
  local a,b = modf(a/b2)
  return a+b*b2*(2^(bits))
end

-- caching function for functions that accept 2 arguments, both of values between
-- 0 and 255. The function to be cached is passed, all values are calculated
-- during loading and a function is returned that returns the cached values (only)
local function cache2arg (fn)
  if not cfg_caching then return fn end
  local lut = {}
  for i=0,0xffff do
    local a,b = floor(i/0x100),i%0x100
    lut[i] = fn(a,b)
  end
  return function (a,b)
    return lut[a*0x100+b]
  end
end

-- splits an 8-bit number into 8 bits, returning all 8 bits as booleans
local function byte_to_bits (b)
  local b = function (n)
    local b = floor(b/n)
    return b%2==1
  end
  return b(1),b(2),b(4),b(8),b(16),b(32),b(64),b(128)
end

-- builds an 8bit number from 8 booleans
local function bits_to_byte (a,b,c,d,e,f,g,h)
  local function n(b,x) return b and x or 0 end
  return n(a,1)+n(b,2)+n(c,4)+n(d,8)+n(e,16)+n(f,32)+n(g,64)+n(h,128)
end

-- debug function for visualizing bits in a string
local function bits_to_string (a,b,c,d,e,f,g,h)
  local function x(b) return b and "1" or "0" end
  return ("%s%s%s%s %s%s%s%s"):format(x(a),x(b),x(c),x(d),x(e),x(f),x(g),x(h))
end

-- debug function for converting a 8-bit number as bit string
local function byte_to_bit_string (b)
  return bits_to_string(byte_to_bits(b))
end

-- debug function for converting a 32 bit number as bit string
local function w32_to_bit_string(a)
  if type(a) == "string" then return a end
  local aa,ab,ac,ad = w32_to_bytes(a)
  local s = byte_to_bit_string
  return ("%s %s %s %s"):format(s(aa):reverse(),s(ab):reverse(),s(ac):reverse(),s(ad):reverse()):reverse()
end

-- bitwise "and" function for 2 8bit number
local band = cache2arg (function(a,b)
    local A,B,C,D,E,F,G,H = byte_to_bits(b)
    local a,b,c,d,e,f,g,h = byte_to_bits(a)
    return bits_to_byte(
      A and a, B and b, C and c, D and d,
      E and e, F and f, G and g, H and h)
  end)

-- bitwise "or" function for 2 8bit numbers
local bor = cache2arg(function(a,b)
    local A,B,C,D,E,F,G,H = byte_to_bits(b)
    local a,b,c,d,e,f,g,h = byte_to_bits(a)
    return bits_to_byte(
      A or a, B or b, C or c, D or d,
      E or e, F or f, G or g, H or h)
  end)

-- bitwise "xor" function for 2 8bit numbers
local bxor = cache2arg(function(a,b)
    local A,B,C,D,E,F,G,H = byte_to_bits(b)
    local a,b,c,d,e,f,g,h = byte_to_bits(a)
    return bits_to_byte(
      A ~= a, B ~= b, C ~= c, D ~= d,
      E ~= e, F ~= f, G ~= g, H ~= h)
  end)

-- bitwise complement for one 8bit number
local function bnot (x)
  return 255-(x % 256)
end

-- creates a function to combine to 32bit numbers using an 8bit combination function
local function w32_comb(fn)
  return function (a,b)
    local aa,ab,ac,ad = w32_to_bytes(a)
    local ba,bb,bc,bd = w32_to_bytes(b)
    return bytes_to_w32(fn(aa,ba),fn(ab,bb),fn(ac,bc),fn(ad,bd))
  end
end

-- create functions for and, xor and or, all for 2 32bit numbers
local w32_and = w32_comb(band)
local w32_xor = w32_comb(bxor)
local w32_or = w32_comb(bor)

-- xor function that may receive a variable number of arguments
local function w32_xor_n (a,...)
  local aa,ab,ac,ad = w32_to_bytes(a)
  for i=1,select('#',...) do
    local ba,bb,bc,bd = w32_to_bytes(select(i,...))
    aa,ab,ac,ad = bxor(aa,ba),bxor(ab,bb),bxor(ac,bc),bxor(ad,bd)
  end
  return bytes_to_w32(aa,ab,ac,ad)
end

-- combining 3 32bit numbers through binary "or" operation
local function w32_or3 (a,b,c)
  local aa,ab,ac,ad = w32_to_bytes(a)
  local ba,bb,bc,bd = w32_to_bytes(b)
  local ca,cb,cc,cd = w32_to_bytes(c)
  return bytes_to_w32(
    bor(aa,bor(ba,ca)), bor(ab,bor(bb,cb)), bor(ac,bor(bc,cc)), bor(ad,bor(bd,cd))
  )
end

-- binary complement for 32bit numbers
local function w32_not (a)
  return 4294967295-(a % 4294967296)
end

-- adding 2 32bit numbers, cutting off the remainder on 33th bit
local function w32_add (a,b) return (a+b) % 4294967296 end

-- adding n 32bit numbers, cutting off the remainder (again)
local function w32_add_n (a,...)
  for i=1,select('#',...) do
    a = (a+select(i,...)) % 4294967296
  end
  return a
end
-- converting the number to a hexadecimal string
local function w32_to_hexstring (w) return format("%08x",w) end

-- calculating the SHA1 for some text
function sha1.hex(msg)
  local H0,H1,H2,H3,H4 = 0x67452301,0xEFCDAB89,0x98BADCFE,0x10325476,0xC3D2E1F0
  local msg_len_in_bits = #msg * 8

  local first_append = char(0x80) -- append a '1' bit plus seven '0' bits

  local non_zero_message_bytes = #msg +1 +8 -- the +1 is the appended bit 1, the +8 are for the final appended length
  local current_mod = non_zero_message_bytes % 64
  local second_append = current_mod>0 and rep(char(0), 64 - current_mod) or ""

  -- now to append the length as a 64-bit number.
  local B1, R1 = modf(msg_len_in_bits / 0x01000000)
  local B2, R2 = modf( 0x01000000 * R1 / 0x00010000)
  local B3, R3 = modf( 0x00010000 * R2 / 0x00000100)
  local B4 = 0x00000100 * R3

  local L64 = char( 0) .. char( 0) .. char( 0) .. char( 0) -- high 32 bits
  .. char(B1) .. char(B2) .. char(B3) .. char(B4) -- low 32 bits

  msg = msg .. first_append .. second_append .. L64

  assert(#msg % 64 == 0)

  local chunks = #msg / 64

  local W = { }
  local start, A, B, C, D, E, f, K, TEMP
  local chunk = 0

  while chunk < chunks do
    --
    -- break chunk up into W[0] through W[15]
    --
    start,chunk = chunk * 64 + 1,chunk + 1

    for t = 0, 15 do
      W[t] = bytes_to_w32(msg:byte(start, start + 3))
      start = start + 4
    end

    --
    -- build W[16] through W[79]
    --
    for t = 16, 79 do
      -- For t = 16 to 79 let Wt = S1(Wt-3 XOR Wt-8 XOR Wt-14 XOR Wt-16).
      W[t] = w32_rot(1, w32_xor_n(W[t-3], W[t-8], W[t-14], W[t-16]))
    end

    A,B,C,D,E = H0,H1,H2,H3,H4

    for t = 0, 79 do
      if t <= 19 then
        -- (B AND C) OR ((NOT B) AND D)
        f = w32_or(w32_and(B, C), w32_and(w32_not(B), D))
        K = 0x5A827999
      elseif t <= 39 then
        -- B XOR C XOR D
        f = w32_xor_n(B, C, D)
        K = 0x6ED9EBA1
      elseif t <= 59 then
        -- (B AND C) OR (B AND D) OR (C AND D
        f = w32_or3(w32_and(B, C), w32_and(B, D), w32_and(C, D))
        K = 0x8F1BBCDC
      else
        -- B XOR C XOR D
        f = w32_xor_n(B, C, D)
        K = 0xCA62C1D6
      end

      -- TEMP = S5(A) + ft(B,C,D) + E + Wt + Kt;
      A,B,C,D,E = w32_add_n(w32_rot(5, A), f, E, W[t], K),
      A, w32_rot(30, B), C, D
    end
    -- Let H0 = H0 + A, H1 = H1 + B, H2 = H2 + C, H3 = H3 + D, H4 = H4 + E.
    H0,H1,H2,H3,H4 = w32_add(H0, A),w32_add(H1, B),w32_add(H2, C),w32_add(H3, D),w32_add(H4, E)
  end
  local f = w32_to_hexstring
  return f(H0) .. f(H1) .. f(H2) .. f(H3) .. f(H4)
end

local function hex_to_binary(hex)
  return hex:gsub('..', function(hexval)
      return string.char(tonumber(hexval, 16))
    end)
end

local xor_with_0x5c = {}
local xor_with_0x36 = {}
-- building the lookuptables ahead of time (instead of littering the source code
-- with precalculated values)
for i=0,0xff do
  xor_with_0x5c[char(i)] = char(bxor(i,0x5c))
  xor_with_0x36[char(i)] = char(bxor(i,0x36))
end

local blocksize = 64 -- 512 bits

function sha1.hmacHex(key, text)
  assert(type(key) == 'string', "key passed to hmacHex should be a string")
  assert(type(text) == 'string', "text passed to hmacHex should be a string")

  if #key > blocksize then
    key = sha1.bin(key)
  end

  local key_xord_with_0x36 = key:gsub('.', xor_with_0x36) .. string.rep(string.char(0x36), blocksize - #key)
  local key_xord_with_0x5c = key:gsub('.', xor_with_0x5c) .. string.rep(string.char(0x5c), blocksize - #key)

  return sha1.hex(key_xord_with_0x5c .. sha1.bin(key_xord_with_0x36 .. text))
end

function sha1.hmacBin(key, text)
  return hex_to_binary(sha1.hmacHex(key, text))
end

return sha1
end)()

function string.startswith(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

local function size_of_hashtable(hh)
  local result = 0
  for _, durations in pairs(hh) do
    result = result + 1
  end
  return result
end

local function get_pos()
  return math.floor(mp.get_property_number("time-pos", 0))
end

local function seek(pos)
  if get_pos() == pos then return end
  mp.set_property_number("time-pos", pos)
end

local function rand(min, max)
  return min + (max - min) * math.random()
end

local function max(values)
  result = values[1]
  for i = 2, #values do
    result = math.max(values[i], result)
  end
  return result
end

local function add_view(pos, force)
  jumped_to_other_pos = math.abs(pos - last_pos) > 4
  if jumped_to_other_pos or force then
    duration = math.floor(last_pos - watch_start)
    if duration > min_view_duration and watch_start > 0 then
      print("SEEK -> add new entry watch_start=" .. watch_start .. " duration=" .. duration)
      key = tostring(watch_start)
      if not views[key] then
        views[key] = {}
      end
      table.insert(views[key], duration)
    end
    watch_start = pos
  end
  last_pos = pos
end

local function get_stats_path()
  local path = mp.get_property("path")
  if not path then return nil end
  local filename = path:match("^.+/(.+)$") or path
--  local digest = utils.subprocess({
--    args = {"sha1sum"},
--    cancellable = false,
--    stdin_data = filename
--  })
--  if digest.status ~= 0 then return nil end
--  local hash = digest.stdout:match("^(%w+)")
  local hash = sha1.hex(filename)
  return stats_dir .. hash .. ".json"
end

local function load_stats()
  local path = stats_file
  local file = io.open(path, "r")
  if not file then return {} end
  local content = file:read("*a")
  file:close()
  print("LOAD STATS " .. path)
  local ok, data = pcall(function() return utils.parse_json(content) end)
  return ok and data or {}
end

local function save_stats()
  print("SAVE STATS")
  if not stats_file or not views then return end
  add_view(get_pos(), true)
  utils.subprocess({
    args = {"mkdir", "-p", stats_dir},
    cancellable = false
  })

  if next(views) == nil then return end
  local file = io.open(stats_file, "w+")
  if file then
    file:write(utils.format_json(views))
    file:close()
  end
end

local function median(t)
  table.sort(t)
  if #t % 2 == 1 then
    return math.floor(t[math.ceil(#t / 2)])
  else
    return math.floor((t[#t / 2] + t[#t / 2 + 1]) / 2)
  end
end

local function merge_view_intervals(views)
  local intervals = {}
  for time, durations in pairs(views) do
    local m = median(durations)
    --print("start=" .. tonumber(time) .. " finish" .. (tonumber(time) + m))
    table.insert(intervals, {start = tonumber(time), finish = tonumber(time) + m})
  end

  table.sort(intervals, function(a, b) return a.start < b.start end)

  local merged = {}
  local current = {starts = {}, finishes = {}}

  for _, interval in ipairs(intervals) do
    if #current.starts == 0 or interval.start <= max(current.finishes) then
      table.insert(current.starts, interval.start)
      table.insert(current.finishes, interval.finish)
    else
      table.insert(merged, {
        start = median(current.starts),
        finish = median(current.finishes)
      })
      current = {
        starts = {interval.start},
        finishes = {interval.finish}
      }
    end
  end

  if #current.starts > 0 then
    table.insert(merged, {
      start = median(current.starts),
      finish = median(current.finishes)
    })
  end

  return merged
end

local function filter_unpopular(views)
  local counts = {}
  for _, durations in pairs(views) do
    table.insert(counts, #durations)
  end
  local threshold = median(counts)
  local filtered = {}
  for time, durations in pairs(views) do
    new_durations = {}
    for _, duration in ipairs(durations) do
      if duration <= max_view_duration then
        table.insert(new_durations, duration)
      end
    end
    if #new_durations >= threshold then
      filtered[time] = new_durations
    end
  end
  return filtered
end

local function start_normal()
  watch_start = get_pos()
  last_pos = watch_start
  normal_mode = true
  mp.osd_message("➡️")
  print("START NORMAL")
end

local function start_normal_at_rand_pos()
  local pos = math.floor(mp.get_property_number("duration") * rand(min_skip, max_skip))
  watch_start = pos
  last_pos = watch_start
  normal_mode = true
  seek(pos)
  mp.osd_message("➡️")
  print("START NORMAL AT RAND POS " .. pos)
end

local next_interval
local function update_interval()
  if interval_index > #best_intervals or not best_intervals[interval_index] then
    mp.commandv("playlist-next")
    return
  end
  local pos = get_pos()

--  if pos < last_pos then
--    print("BACK TO NORMAL")
--    start_normal()
--    return
--  end
  last_pos = pos

  local interval = best_intervals[interval_index]
  if pos < interval.start then
    seek(interval.start)
  elseif pos > interval.finish then
    next_interval()
  end
end

next_interval = function()
  interval_index = interval_index + 1
  update_interval()
end

local function start_best_moments()
  local stats = load_stats()
  if not next(stats) then
    print("UNSEEN YET")
    resume_to_best_moments = true
    start_normal_at_rand_pos()
    return
  end
  normal_mode = false
  print("stats -> " .. size_of_hashtable(stats))
  stats = filter_unpopular(stats)
  print("unpopular -> " .. size_of_hashtable(stats))
  best_intervals = merge_view_intervals(stats)
  print("best intervals -> " .. #best_intervals)
  interval_index = math.floor(rand(1, math.max(1, #best_intervals * 0.2)))
  print("INTERVAL INDEX " .. interval_index .. "/" .. #best_intervals)
  local interval = best_intervals[interval_index]
  if interval then
    local pos = interval.start
    watch_start = pos
    last_pos = pos
    seek(pos)
  end
  mp.osd_message("🪄✨")
  print("START BEST MOMENTS watch_start=" .. watch_start)
end

local function init()
  read_options(options, "best_moments")
  normal_mode = options.start_normal

  print("READ OPTIONS: normal = " .. tostring(normal_mode))

  local allowed_directories = {}
  for i in string.gmatch(options.allowed_directories, "([^,]+)") do
    table.insert(allowed_directories, i)
  end

  print("READ OPTIONS: #allowed_directories = " .. tostring(#allowed_directories))

  stats_file = mp.get_property("path")
  expected_path = #allowed_directories == 0
  print("initial expected path = " .. tostring(expected_path))
  for _, i in ipairs(allowed_directories) do
    print(" dir " .. i)
    if string.startswith(stats_file, i .. "/") then
      expected_path = true
      break
    end
  end
  if not expected_path then
    print("unexpected path")
    return
  end

  mp.observe_property("time-pos", "native", function(_, pos)
    if pos == nil then return end
    if normal_mode then
      add_view(math.floor(pos), false)
    else
      update_interval()
    end
  end)

  for _, i in ipairs({"shutdown", "end-file"}) do
    mp.register_event(i, save_stats)
  end

  mp.remove_key_binding("/")
  mp.add_key_binding("/", "next_interval", function()
    print("NEXT INTERVAL")
    next_interval()
  end)

  mp.add_key_binding("c", "delete_stats", function()
    print("CLEAN stats")
    views = {}
    os.remove(stats_file)
    start_normal()
  end)

  mp.add_key_binding("a", "toggle_best_moments", function()
    resume_to_best_moments = false
    if normal_mode then
      save_stats()
      start_best_moments()
    else
      start_normal()
    end
  end)

  ready = true
end

mp.register_event("file-loaded", function()
  if not ready then init() end
  if not ready then return end

  stats_file = get_stats_path()
  print("LOADED " .. stats_file)

  if resume_to_best_moments then
    print("RESUME to best moments")
    normal_mode = false
  end

  views = load_stats()
  if normal_mode then
    start_normal_at_rand_pos()
  else
    start_best_moments()
  end
end)
