#!/usr/bin/env ruby

line = ARGV[0].to_i
filename = ARGV[1].gsub(/^\.\//, '')
pattern = ARGV[2]
jupyter_url = ARGV[3]
jupyter_path = ARGV[4]

ANCHOR_REGEX = /\s*#\s(.*?)\\n",$/

def parse_anchor(filename, line)
  File.foreach(filename)
      .first(line)
      .reverse
      .select { |line| line.match? ANCHOR_REGEX }
      .take(1)
      .map { |line| line.match(ANCHOR_REGEX)[1].gsub(/^/, '#').tr(' ', '-') }[0] || ''
end

file_extension = File.extname(filename)
is_jupyter = file_extension == '.ipynb' && (Dir.pwd.start_with? jupyter_path)
if is_jupyter
  anchor = parse_anchor(filename, line)
  jupyter_path = File.join(Dir.pwd, filename).gsub(/^#{jupyter_path}/, '')
  system("chromium '#{jupyter_url}#{jupyter_path}#{anchor}'")
else
  system("nvim -c '/#{pattern}' -c '#{line}' '#{filename}'")
end
