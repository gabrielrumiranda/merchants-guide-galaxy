class Validator 
  ROMAN_VALUES = [1, 5, 10, 50, 100, 500, 1000].freeze

  def self.validate_push(value)
    if roman?(value)
      validade_roman_precedence(value)
    else
      true
    end
  end

  def self.validade_roman_precedence(value)
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

  def self.roman?(value)
    ROMAN_VALUES.include?(value)
  end
end
