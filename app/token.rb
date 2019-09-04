# frozen_string_literal: true

class Token
  attr_accessor :name, :value
  def initialize(name, value)
    @name = name
    @value = value
  end
end
