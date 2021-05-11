#!/usr/bin/env ruby

require 'open3'

buffer = ''
%w[clipboard primary secondary].each do |i|
  buffer = `xsel -o --#{i} 2>>/dev/null`
  # puts buffer unless buffer.empty?
  break unless buffer.empty?
end

Open3.popen3('tmux load-buffer -') do |stdin, _stdout, _stderr, _wait_thr|
  stdin.write buffer
  stdin.close
end

system 'tmux paste-buffer'
