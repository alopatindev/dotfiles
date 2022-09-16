#!/usr/bin/env ruby

# TODO: up button for history

def delimiters(text)
  dots = text.count('.')
  has_dots = dots > 0

  has_commas = text.include?(',')
  has_spaces = text.include?(' ')

  possible_dollars, possible_cents = text.split('.') if dots == 1

  single_dot_cents_delimiter = dots == 1 &&
                               !has_commas && !has_spaces &&
                               (possible_dollars.to_i == 0 || (possible_cents.length > 2 && possible_cents.to_i != 0))

  cents_delimiter = if has_dots && text.match(/\.[0-9]{1,2}$/)
                      '.'
                    elsif has_commas && text.match(/,[0-9]{1,2}$/)
                      ','
                    elsif single_dot_cents_delimiter
                      '.'
                    end

  thousands_delimiter = if cents_delimiter == '.' && has_commas
                          ','
                        elsif cents_delimiter == ',' && has_dots
                          '.'
                        end
  if thousands_delimiter.nil? && cents_delimiter.nil?
    thousands_delimiter = if has_dots
                            '.'
                          elsif has_commas
                            ','
                          end
  end

  thousands_delimiter = ' ' if thousands_delimiter.nil? && has_spaces

  if !cents_delimiter.nil? && text.count(cents_delimiter) > 1
    warn('invalid input')
    cents_delimiter = nil
    thousands_delimiter = nil
  end

  # puts "#{text} => cents, thousands => #{[cents_delimiter, thousands_delimiter]}"
  raise if !cents_delimiter.nil? && !thousands_delimiter.nil? && cents_delimiter == thousands_delimiter

  [cents_delimiter, thousands_delimiter]
end

def normalize(text)
  return nil if text.match(/[^0-9., ]/)

  cents_delimiter, thousands_delimiter = delimiters(text)
  if thousands_delimiter.nil?
    result = text
  else
    result = text.gsub(thousands_delimiter, '')
    result = result.sub(cents_delimiter, '.') unless cents_delimiter.nil?
  end
  result
end

def tokenize(text)
  pattern = /[0-9., ]+/
  matched = text.scan(pattern)
  non_numbers = text.split(pattern)
  result = []
  non_numbers.each_with_index do |substr, i|
    result << substr
    result << matched[i] if matched[i]
  end
  result.reject(&:empty?)
end

# raise unless delimiters('1000') == [nil, nil]
# raise unless delimiters('1,000') == [nil, ',']
# raise unless delimiters('1 000') == [nil, ' ']
# raise unless delimiters('1.000') == [nil, '.']
# raise unless delimiters('1,000,000') == [nil, ',']
# raise unless delimiters('1.000.000') == [nil, '.']
# raise unless delimiters('1 000 000') == [nil, ' ']
# raise unless delimiters('1,000,000') == [nil, ',']
# raise unless delimiters('10,000,000') == [nil, ',']
# raise unless delimiters('1,000,000.00') == ['.', ',']
# raise unless delimiters('1 000 000.00') == ['.', ' ']
# raise unless delimiters('1 000,00') == [',', ' ']
# raise unless delimiters('10.0') == ['.', nil]
# raise unless delimiters('1,000,00') == [nil, nil] # invalid
# raise unless delimiters('1,00,00') == [nil, nil] # invalid
# raise unless normalize('1.000.000') == '1000000'
# raise unless normalize('1.000.000,44') == '1000000.44'
# raise unless normalize('1 000 000.00') == '1000000.00'
# raise unless normalize('100.00') == '100.00'
# raise unless normalize('44.4') == '44.4'
# raise unless normalize('1,000.00 + 345.33').nil?
# raise unless normalize('0.0012') == '0.0012'
# raise unless normalize('0.001') == '0.001'
# raise unless normalize('444.4411') == '444.4411'

while (input = gets)
  IO.popen(['bc', '-ql'], 'r+') do |pipe|
    input = input.strip
    tokens = tokenize(input)
    new_input = tokens.map do |i|
      number = normalize(i)
      if number.nil?
        i
      else
        number.strip
      end
    end.join(' ').strip

    puts "corrected to:\n#{new_input}\n" if input != new_input

    pipe.puts new_input
    pipe.close_write
    puts pipe.read
  end
end
