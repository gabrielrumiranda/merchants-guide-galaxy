require_relative './token'

class Line 
  attr_accessor :tokens, :accumulate, :dictionary

  def initialize
    @tokens = Array.new
    @dictionary = Hash.new
    @accumulate = 0
  end

  def push(value)
    @tokens.push(value)
  end

  def validate_push(value)
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
    if token.value && validate_push(token)
      if(@tokens.last) 

        if(@tokens.last.value >= token.value)
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

  def add_dictionary (name, value)
    @dictionary[name] = value
  end

  def print
    @tokens.each do |token|
      puts token.name
    end
    puts "Result: #{@accumulate}"
  
  end

end
