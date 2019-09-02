require_relative './token'

class Line 
  attr_accessor :tokens, :accumulate

  def initialize
    @tokens = Array.new
    @accumulate = 0
  end

  def push(value)
    @tokens.push(value)
  end

  def validate_push(value)
    last_numbers = @tokens.last(3)

    if (last_numbers.size < 3)
      true
    else
      last_numbers.uniq.size > 1

    end
  end

  def add(token)
    if(validate_push(token))
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

  def print
    @tokens.each do |token|
      puts token.name
    end
    puts "Result: #{@accumulate}"
  
  end

end
