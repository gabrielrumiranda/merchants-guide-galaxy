# frozen_string_literal: true

require_relative './line'
require_relative './token'
require_relative './dictionary'

#
class Parser
  attr_reader :line
  
  def initialize
    @dictionary = Dictionary.new
  end

  def parse(file_line)
    tokens = file_line.split(' ')
    is_position = tokens.find_index('is')
    if !is_position
      'I have no idea what you are talking about'
    elsif tokens.last == '?'
      infer(tokens, is_position)
    elsif tokens.last == 'Credits'
      parse_galaxy_number(tokens, is_position)
      '-'
    else
      parse_roman_number(tokens, is_position)
      '-'
    end
  end

  def parse_roman_number(tokens, is_position)
    roman_number = tokens[is_position + 1]
    galaxy_number = tokens[is_position - 1]

    case roman_number
    when 'I'
      @dictionary.add_word(galaxy_number, 1)
    when 'V'
      @dictionary.add_word(galaxy_number, 5)
    when 'X'
      @dictionary.add_word(galaxy_number, 10)
    when 'L'
      @dictionary.add_word(galaxy_number, 50)
    when 'C'
      @dictionary.add_word(galaxy_number, 100)
    when 'D'
      @dictionary.add_word(galaxy_number, 500)
    when 'M'
      @dictionary.add_word(galaxy_number, 1000)

    else
      puts "the romans don't know this number"
    end
  end

  def parse_galaxy_number(tokens, is_position)
    galaxy_number = tokens[0, is_position]
    result = tokens[is_position + 1]
    galaxy_number.each do |number|
      number_value = @dictionary.words[number]
      next if number_value

      preliminar_number = galaxy_number.reject { |n| n == number }
      preliminar_result = calculate_preliminar_number(preliminar_number)
      @dictionary.add_word(number, Integer(result) / preliminar_result.to_f)
    end
  end

  def calculate_preliminar_number(tokens)
    line = Line.new
    tokens.each do |n|
      line.add_buffer(Token.new(n, @dictionary.words[n]))
    end
    line.accumulate
  end

  def infer(tokens, is_position)
    line = Line.new
    tokens.delete('?')
    galaxy_number = tokens[is_position + 1, tokens.size]
    galaxy_number.each do |token|
      number_value = @dictionary.words.fetch(token)
      if !number_value
        puts 'I have no idea what you are talking about'
        break
      else
        line.add_buffer(Token.new(token, number_value))
      end
    end
    line.accumulate
  end
end
