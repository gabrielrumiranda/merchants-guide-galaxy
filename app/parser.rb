# frozen_string_literal: true

require_relative './line'
require_relative './token'
require_relative './dictionary'

class Parser
  ROMAN_MAP = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }.freeze

  def initialize(dictionary: Dictionary.new)
    @dictionary = dictionary
  end

  def parse!(file_line)
    tokens = file_line.split(' ')
    is_position = tokens.find_index('is')
    return 'I have no idea what you are talking about' unless is_position

    if tokens.last == '?'
      infer(tokens, is_position)
    elsif tokens.last == 'Credits'
      parse_galaxy_number!(tokens, is_position)
      '-'
    else
      parse_roman_number!(tokens, is_position)
      '-'
    end
  end

  def can_parse?(file_line)
    tokens = file_line.split(' ')
    is_position = tokens.find_index('is')
    if !is_position
      'I have no idea what you are talking about'
    else
      [tokens, is_position]
    end
  end

  def parse_roman_number!(tokens, is_position)
    return unless is_position

    roman_number = tokens[is_position + 1]
    galaxy_number = tokens[is_position - 1]
    roman_value = ROMAN_MAP[roman_number]
    puts 'teste'
    puts roman_value
    @dictionary.add_word!(galaxy_number, roman_value) if roman_value

    puts "the romans don't know this number"
  end

  def parse_galaxy_number!(tokens, is_position)
    return unless is_position

    galaxy_number = tokens[0, is_position]
    result = tokens[is_position + 1]
    galaxy_number.each do |number|
      next if @dictionary.words[number]

      preliminar_number = galaxy_number.reject { |n| n == number }
      preliminar_result = calculate_preliminar_number(preliminar_number)
      next if preliminar_result.zero?

      @dictionary.add_word!(number, Integer(result) / preliminar_result.to_f)
    end
  end

  def calculate_preliminar_number(tokens)
    line = Line.new
    tokens.each do |n|
      line.add_buffer!(Token.new(n, @dictionary.words[n]))
    end
    line.accumulate
  end

  def infer(tokens, is_position)
    return 0 unless is_position

    line = Line.new
    tokens.delete('?')
    galaxy_number = tokens[is_position + 1, tokens.size]
    galaxy_number.each do |token|
      number_value = @dictionary.words[token]
      break unless number_value

      line.add_buffer!(Token.new(token, number_value))
    end
    line.accumulate
  end
end
