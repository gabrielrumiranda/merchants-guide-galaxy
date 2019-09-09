# frozen_string_literal: true
#
require_relative './token'
require_relative './validator'

class Line
  attr_accessor :tokens, :accumulate
  
  def initialize
    @tokens = []
    @accumulate = 0
  end

  def push(value)
    @tokens.push(value)
  end

  def add_buffer(token)
    return unless token.value && Validator.validate_push(token)

    if @tokens.last
      if !Validator.roman?(token.value)
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
end
