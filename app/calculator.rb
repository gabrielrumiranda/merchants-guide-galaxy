# frozen_string_literal: true

require_relative './line'
require_relative './token'

class Calculator
  attr_reader :line
  def initialize
    @line = Line.new
  end

  def read(path)
    IO.foreach(path) do |line|
      @line.clean_line
      if !line.nil? && !line.empty?
        puts line
        result = parse(line)
        puts result
      end
    end
  end

  def parse(file_line)
    tokens = file_line.split(' ')
    is_position = tokens.find_index('is')
    if !is_position
      'I have no idea what you are talking about'
    else
      if tokens.last == '?'
        infer(tokens, is_position)
      elsif tokens.last == 'Credits'
        parse_galaxy_number(tokens, is_position)
      else
        parse_roman_number(tokens, is_position)
      end
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
      aux_line = Line.new
      aux_line.dictionary = @line.dictionary
      preliminar_number.each do |n|
        aux_line.add_buffer(Token.new(n, aux_line.dictionary[n]))
      end
      preliminar_result = aux_line.accumulate
      @line.dictionary[number] = Integer(result) / preliminar_result.to_f
    end
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