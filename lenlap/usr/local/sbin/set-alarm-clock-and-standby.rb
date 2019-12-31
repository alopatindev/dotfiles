#!/usr/bin/env ruby

FINISH_TIME = '10:00 am'.freeze
SUNRISE_TIME_SECS = 1800
POINTS = [[0, 0, 0], [25, 15, 96], [255, 176, 0], [255, 220, 142]].freeze
SUNRISE_TIME_PER_POINT = SUNRISE_TIME_SECS / POINTS.length
PIC_PATH = '/tmp/alarm-clock.png'.freeze
XDISPLAY = 4
DISPLAY_SIZE = `xdpyinfo | awk '/dimensions:/ { print $2; exit }'`.strip.split('x').map { |i| "#{i}!" }.join('x')
BACKLIGHT_PATH = '/sys/class/backlight/intel_backlight'.freeze
BRIGHTNESS_PATH = "#{BACKLIGHT_PATH}/brightness".freeze
MAX_BRIGHTNESS = `cat #{BACKLIGHT_PATH}/max_brightness`.to_i
RTC_ACCURACY_SECS = 10

def interpolate(start_color, end_color, start_time, end_time, time)
  delta_color = end_color - start_color
  delta_time = end_time - start_time
  start_color + (time * delta_color) / delta_time
end

def make_image(r, g, b)
  svg = "<?xml version=\"1.0\" encoding=\"UTF-8\"><svg width=\"1\" height=\"1\"><rect fill=\"rgb(#{r}, #{g}, #{b})\" width=\"1\" height=\"1\"/></svg>"
  system "echo '#{svg}' | convert -resize '#{DISPLAY_SIZE}' - #{PIC_PATH}"
end

def get_brightness
  File.open(BRIGHTNESS_PATH, 'r') do |f|
    f.read.to_i
  end
end

def set_brightness(brightness)
  begin
    File.open(BRIGHTNESS_PATH, 'a') do |f|
      f.write(brightness.to_s)
    end
  rescue StandardError
  end
  brightness
end

wake_time = "today #{FINISH_TIME} - #{SUNRISE_TIME_SECS} seconds"
print [`date +%s`.to_i, `date +%s -d "#{wake_time} - #{SUNRISE_TIME_SECS} seconds"`.to_i]
if `date +%s`.to_i >= `date +%s -d "#{wake_time} - #{SUNRISE_TIME_SECS} seconds"`.to_i
  wake_time = "tomorrow #{FINISH_TIME} - #{SUNRISE_TIME_SECS} seconds"
end
wake_time_timestamp = `date +%s -d "#{wake_time}"`.to_i

system "rtcwake -m no -l -t $(date +%s -d '#{wake_time}') ; logger 'set wakeup timer to #{wake_time}'"

colors = POINTS.each_cons(2).flat_map do |start_point, end_point|
  (0..SUNRISE_TIME_PER_POINT).map do |time|
    (0...3).map { |channel| interpolate(start_point[channel], end_point[channel], 0, SUNRISE_TIME_PER_POINT, time) }
  end
end

initial_brightness = get_brightness
brightness = set_brightness(0)

system '/usr/local/sbin/standby'

current_time_timestamp = `date +%s`.to_i
if current_time_timestamp <= wake_time_timestamp - RTC_ACCURACY_SECS || current_time_timestamp <= wake_time_timestamp + RTC_ACCURACY_SECS
  brightness_step = MAX_BRIGHTNESS / SUNRISE_TIME_SECS
  make_image(0, 0, 0)
  system "X :#{XDISPLAY} & X_PID=$! && sleep 0.5s && DISPLAY=:#{XDISPLAY} feh -R 1 --scale-down --auto-zoom #{PIC_PATH} && kill ${X_PID} && echo -n #{initial_brightness} >> #{BRIGHTNESS_PATH} &"

  for r, g, b in colors
    make_image(r, g, b)
    set_brightness(get_brightness + brightness_step)
    sleep 1
  end
end

system 'echo -n 0 > /sys/class/rtc/rtc0/wakealarm'
