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
    position_of_is = tokens.find_index('is')
    return 'I have no idea what you are talking about' unless position_of_is

    if tokens.last == '?'
      infer(tokens, position_of_is)
    elsif tokens.last == 'Credits'
      parse_galaxy_number!(tokens, position_of_is)
      '-'
    else
      parse_roman_number!(tokens, position_of_is)
      '-'
    end
  end

  def parse_roman_number!(tokens, position_of_is)
    return unless position_of_is

    roman_number = tokens[position_of_is + 1]
    galaxy_number = tokens[position_of_is - 1]
    roman_value = ROMAN_MAP[roman_number]
    if roman_value
      @dictionary.add_word!(galaxy_number, roman_value)
    else
      puts "the romans don't know this number"
    end
  end

  def parse_galaxy_number!(tokens, position_of_is)
    return unless position_of_is

    galaxy_number = tokens[0, position_of_is]
    result = tokens[position_of_is + 1]
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

  def infer(tokens, position_of_is)
    return 0 unless position_of_is

    line = Line.new
    tokens.delete('?')
    galaxy_number = tokens[position_of_is + 1, tokens.size]
    galaxy_number.each do |token|
      number_value = @dictionary.words[token]
      break unless number_value

      line.add_buffer!(Token.new(token, number_value))
    end
    line.accumulate
  end
end
