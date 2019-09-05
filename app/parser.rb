# frozen_string_literal: true

require_relative './line'
require_relative './token'
#
class Parser
  attr_reader :line
  def initialize
    @line = Line.new
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
      @line.add_dictionary(galaxy_number, 1)
    when 'V'
      @line.add_dictionary(galaxy_number, 5)
    when 'X'
      @line.add_dictionary(galaxy_number, 10)
    when 'L'
      @line.add_dictionary(galaxy_number, 50)
    when 'C'
      @line.add_dictionary(galaxy_number, 100)
    when 'D'
      @line.add_dictionary(galaxy_number, 500)
    when 'M'
      @line.add_dictionary(galaxy_number, 1000)

    else
      puts "the romans don't know this number"
    end
  end

  def parse_galaxy_number(tokens, is_position)
    galaxy_number = tokens[0, is_position]
    result = tokens[is_position + 1]
    galaxy_number.each do |number|
      number_value = @line.dictionary[number]
      next if number_value

      preliminar_number = galaxy_number.reject { |n| n == number }
      preliminar_result = calculate_preliminar_number(preliminar_number, @line.dictionary)
      @line.dictionary[number] = Integer(result) / preliminar_result.to_f
    end
  end

  def calculate_preliminar_number(tokens, dictionary)
    line = Line.new
    line.dictionary = dictionary
    tokens.each do |n|
      line.add_buffer(Token.new(n, line.dictionary[n]))
    end
    line.accumulate
  end

  def infer(tokens, is_position)
    tokens.delete('?')
    galaxy_number = tokens[is_position + 1, tokens.size]
    galaxy_number.each do |token|
      number_value = @line.dictionary.fetch(token)
      if !number_value
        puts 'I have no idea what you are talking about'
        break
      else
        @line.add_buffer(Token.new(token, number_value))
      end
    end
    @line.accumulate
  end
end
