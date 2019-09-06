# frozen_string_literal: true
#
require_relative './token'

class Line
  attr_accessor :tokens, :accumulate, :dictionary
  ROMAN_VALUES = [1, 5, 10, 50, 100, 500, 1000].freeze

  def initialize
    @tokens = []
    @dictionary = {}
    @accumulate = 0
  end

  def push(value)
    @tokens.push(value)
  end

  def validate_push(value)
    if ROMAN_VALUES.index(value)
      validade_roman_precedence(value)
    else
      true
    end
  end

  def validade_roman_precedence(value)
    index_value = ROMAN_VALUES.index(value)
    index_last_token = ROMAN_VALUES.index(@tokens.last)
    if index_last_token
      if index_last_token > index_value
        true
      elsif index_last_token < index_value
        index_last_token + 1 == index_value
      else
        last_numbers = @tokens.last(3)
        if last_numbers.size < 3
          true
        else
          last_numbers.uniq.size > 1
        end
      end
    else
      true
    end
  end

  def add_buffer(token)
    return unless token.value && validate_push(token)

    if @tokens.last
      if !ROMAN_VALUES.include?(token.value)
        @accumulate *= token.value
      elsif @tokens.last.value >= token.value
        @accumulate += token.value
      else
        @accumulate = token.value - @accumulate
      end
    else
      @accumulate += token.value
    end

    @tokens.push(token)
  end

  def add_dictionary(name, value)
    @dictionary[name] = value
  end

  def clean_line
    @tokens.clear
    @accumulate = 0
  end
end
