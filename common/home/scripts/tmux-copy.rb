#!/usr/bin/env ruby

require 'open3'

# clipboards = %w[clipboard primary secondary]
clipboards = %w[clipboard]
buffer = STDIN.read

clipboards.each do |i|
  system("xsel --clear --#{i}")
  Open3.popen3("xsel --input --#{i}") do |stdin, _stdout, _stderr, _wait_thr|
    stdin.write buffer
    stdin.close
  end
end
