#!/usr/bin/env ruby

require 'inifile'

APP_FIELDS = %w[Exec TryExec StartupWMClass].freeze
BAD_ARGS = ['env'].freeze

CATEGORY_TO_TAG = {
  'TerminalEmulator' => 2,

  'Chat' => 3,
  'InstantMessaging' => 3,
  'Telephony' => 3,
  'VideoConference' => 3,

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

apps = Dir.glob('{/usr,/var/lib/flatpak/exports}/share/applications/*.desktop').map do |f|
  begin
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
  rescue StandardError
    app_names = []
    categories = []
  end
  [app_names, categories]
end
          .flat_map do |app_names, categories|
            category = categories.map { |c| CATEGORY_TO_TAG[c] }.reject(&:nil?).first
            app_names.map { |name| [name, category] }
          end
          .select { |app_name, tag| !app_name.nil? && !app_name.empty? && !tag.nil? }
          .to_h
          .to_a
          .map { |app_name, tag| "#{app_name}\t#{tag}" }
          .join("\n")

puts apps
