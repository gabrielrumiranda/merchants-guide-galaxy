class Dictionary
  attr_accessor :words
  def initialize(words: {})
    @words = words
  end

  def add_word(name, value)
    @words[name] = value
  end
end
