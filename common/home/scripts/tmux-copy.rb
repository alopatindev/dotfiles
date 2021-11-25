#!/usr/bin/env ruby

require 'open3'

buffer = STDIN.read

## clipboards = %w[clipboard primary secondary]
# clipboards = %w[clipboard]
#
# clipboards.each do |i|
#  system("xsel --clear --#{i}")
#  # Open3.popen3("xsel --input --#{i}") do |stdin, _stdout, _stderr, thread|
#  Open3.popen3("xsel --input --#{i}") do |stdin, _stdout, _stderr, thread|
#    stdin.write buffer
#    stdin.close
#    thread.join
#  end
#  system('xsel --keep')
# end

Open3.popen3('xclip -quiet -i -selection clipboard') do |stdin, _stdout, _stderr, thread|
  stdin.write buffer
  stdin.close
  thread.join
end
