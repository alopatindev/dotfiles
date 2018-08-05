#!/usr/bin/env ruby

require 'shellwords'

BROWSER = ENV['BROWSER'] || 'chromium'
EDITOR = ENV['EDITOR'] || 'nvim'

ANCHOR_REGEX = /\s*#\s(.*?)\\n",$/

def parse_anchor(filename, line)
  File.foreach(filename)
      .first(line)
      .reverse
      .select { |line| line.match? ANCHOR_REGEX }
      .take(1)
      .map { |line| line.match(ANCHOR_REGEX)[1].sub(/^/, '#').tr(' ', '-') }[0] || ''
end

line = ARGV[0].to_i
filename = ARGV[1].sub(/^\.\//, '')
pattern = ARGV[2]
jupyter_url = ARGV[3]
jupyter_path = ARGV[4]

file_extension = File.extname(filename)
is_jupyter = file_extension == '.ipynb' && (Dir.pwd.start_with? jupyter_path)
command =
  if is_jupyter
    anchor = parse_anchor(filename, line)
    jupyter_path = File.join(Dir.pwd, filename).sub(/^#{jupyter_path}/, '')
    url = "#{jupyter_url}#{jupyter_path}#{anchor}"
    [BROWSER, url]
  else
    [EDITOR, '-c', "/#{pattern}", '-c', line, filename]
  end

system Shellwords.join(command)
