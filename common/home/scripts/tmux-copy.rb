#!/usr/bin/env ruby

require 'open3'

buffer = STDIN.read

%w[clipboard primary secondary].each do |i|
  Open3.popen3("xsel -i --#{i}") do |stdin, _stdout, _stderr, _wait_thr|
    stdin.write buffer
    stdin.close
  end
end
