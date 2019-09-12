# frozen_string_literal: true

class Dictionary
  attr_accessor :words

  def initialize
    @words = {}
  end

  def add_word(name, value)
    @words[name] = value
  end
end
