#!/usr/bin/env ruby

line = ARGV[0].to_i
filename = ARGV[1].gsub(/^\.\//, '')
pattern = ARGV[2]

ANCHOR_REGEX = /\s*#\s(.*)\\n",$/
JUPYTER_URL = 'http://localhost:8888/notebooks'.freeze
JUPYTER_PATH = "#{Dir.home}/git/workbooks-alopatindev".freeze

def parse_anchor(filename, line)
  File.foreach(filename)
      .first(line)
      .reverse
      .select { |line| line.match? ANCHOR_REGEX }
      .take(1)
      .map { |line| line.match(ANCHOR_REGEX)[1].gsub(/^/, '#').tr(' ', '-') }[0] || ''
end

file_extension = File.extname(filename)
is_jupyter = file_extension == '.ipynb' && (Dir.pwd.start_with? JUPYTER_PATH)
if is_jupyter
  anchor = parse_anchor(filename, line)
  jupyter_path = File.join(Dir.pwd, filename).gsub(/^#{JUPYTER_PATH}/, '')
  system("chromium '#{JUPYTER_URL}#{jupyter_path}#{anchor}'")
else
  system("nvim -c '/#{pattern}' -c '#{line}' '#{filename}'")
end
