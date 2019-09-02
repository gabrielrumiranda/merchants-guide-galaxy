require_relative './line'
require_relative './token'

class Calculator
  attr_reader :line
  def initialize(buffer)
    @line = Line.new
    @buffer = buffer
  end

  def read
    @buffer = gets.chomp
  end
  
  def parse
    tokens = @buffer.split(' ')
    tokens.each do |word|
      puts word
      case word
      when 'glob'
        @line.add(Token.new(word, 1))
      when 'prok'
        @line.add(Token.new(word, 5))
      when 'pish'
        @line.add(Token.new(word, 10))
      when 'tegj'
        @line.add(Token.new(word, 50))
      else
        puts('Word Invalid')
      end
    end
  end
  
  def calculate
    parse
    @line.print
  end

end
