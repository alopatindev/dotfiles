#!/usr/bin/env ruby

require 'inifile'

APP_FIELDS = %w[Exec TryExec].freeze
BAD_ARGS = ['env'].freeze

CATEGORY_TO_TAG = {
  'Chat' => 1,
  'InstantMessaging' => 1,
  'Telephony' => 1,
  'VideoConference' => 1,

  'TerminalEmulator' => 2,

  'WebBrowser' => 3,

  'Development' => 4,
  'Finance' => 4,
  'IDE' => 4,
  'Math' => 4,
  'TextEditor' => 4,
  'Utility' => 4,

  'Audio' => 5,
  'AudioVideo' => 5,
  'AudioVideoEditing' => 5,
  'Player' => 5,
  'TV' => 5,

  'Graphics' => 6,

  'Filesystem' => 7,
  'Settings' => 7,

  'Emulator' => 8,
  'Game' => 8,

  'Office' => 9,
  'Presentation' => 9,
  'Spreadsheet' => 9
}.freeze

apps = Dir.glob('/usr/share/applications/*.desktop').map do |f|
  conf = IniFile.load(f, comment: '#')
  entry = conf['Desktop Entry']
  app_names = entry
              .select { |k| APP_FIELDS.any? k }
              .flat_map do |_, v|
    v.split(' ')
     .select do |arg|
      (BAD_ARGS.none? arg) && !(arg =~ /^[a-z\/].*/).nil?
    end.flat_map { |v| v.split('/').last }
  end
  categories = (entry['Categories'] || '').split(';')
  [app_names, categories]
end
          .map { |app_names, categories| [app_names.first, categories.map { |c| CATEGORY_TO_TAG[c] }.reject(&:nil?).first] }
          .select { |app_name, tag| !app_name.nil? && !app_name.empty? && !tag.nil? }
          .map { |app_name, tag| "#{app_name}\t#{tag}" }
          .join("\n")

puts apps
