# frozen_string_literal: true

require_relative './token'

class Line
  attr_accessor :tokens, :accumulate, :dictionary

  def initialize
    @tokens = []
    @dictionary = {}
    @accumulate = 0
  end

  def push(value)
    @tokens.push(value)
  end

  def validate_push(_value)
    last_numbers = @tokens.last(3)

    if last_numbers.size < 3
      true
    elsif last_numbers.size >= 3
      last_numbers.uniq.size > 1
    else
      false
    end
  end

  def add_buffer(token)
    roman_values = [1, 5, 10, 50, 100, 500, 1000]

    if token.value && validate_push(token)
      if @tokens.last
        if !roman_values.include?(token.value)
          @accumulate *= token.value
        else
          if @tokens.last.value >= token.value
            @accumulate += token.value
          else
            @accumulate = token.value - @accumulate
          end
        end
      else
        @accumulate += token.value
      end
      @tokens.push(token)
    end
  end

  def add_dictionary(name, value)
    @dictionary[name] = value
  end

  def clean_line
    @tokens.clear
    @accumulate = 0
  end
end
