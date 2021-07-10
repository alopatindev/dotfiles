#!/bin/env ruby

# update old gentoo system without fuss
# usage: em-auto-exclude -uDNa @system

require 'set'

def extract_package_name(package)
  `equery -C meta '#{package}' | grep '^Location' | sed 's!.*/usr/portage/!!'`.strip
end

args = ARGV.join(' ')

exclude = [].to_set
analyzed_packages = [].to_set

loop do
  exclude_len = exclude.length
  command = "emerge -p #{args} --exclude='#{exclude.to_a.join(' ')}' 2>>/dev/stdout"
  puts command
  emerge_out = `#{command}`
               .split("\n")
               .map { |i| i.gsub '"', '' }
               .select { |i| !i.include? '@' }

  required_by = emerge_out
                .select { |i| i.include? ' required by ' }
                .map { |i| i.gsub(/.* by /, '') }
                .map { |i| i.gsub(/\s.*/, '') }
                .map { |i| i.gsub(/\[.*/, '') }
                .map { |i| i.gsub(/[(,]/, '') }
                .map { |i| "=#{i}" }
                .select { |i| !i.empty? }

  installed = emerge_out
              .select { |i| i.include? ', installed)' }
              .map { |i| i.gsub(/^\s+/, '') }
              .map { |i| i.gsub(/[\s\[(,].*/, '') }
              .select { |i| !i.empty? }

  to_analyze = (installed + required_by).to_set - analyzed_packages
  exclude += to_analyze.to_a.map { |i| extract_package_name(i) }.to_set
  analyzed_packages += to_analyze

  next unless exclude_len == exclude.length

  puts 'FINISHING'
  to_install = emerge_out
               .select { |i| i.start_with? '[ebuild ' }
               .map { |i| '=' + (i.slice 17, i.length).gsub(/ .*/, '').strip }
               .join(' ')
  command = "em #{args} --nodeps --oneshot #{to_install}"
  puts command
  system command
  break
end
