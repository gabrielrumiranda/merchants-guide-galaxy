# frozen_string_literal: true
#
require_relative './token'
require_relative './token_validator'

class Line
  attr_accessor :tokens, :accumulate

  def initialize
    @tokens = []
    @accumulate = 0
  end

  def push(token)
    @tokens.push(token)
  end

  def add_buffer(token)
    return unless token.value && TokenValidator.validate_push(token, @tokens)
    
    if @tokens.last
      if !TokenValidator.roman?(token.value)
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
