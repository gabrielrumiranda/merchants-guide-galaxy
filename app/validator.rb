class Validator 
  ROMAN_VALUES = [1, 5, 10, 50, 100, 500, 1000].freeze

  def self.validate_push(token, buffer)
    return true unless roman?(token.value)

    validade_roman_precedence(token.value, buffer)
  end

  def self.validade_roman_precedence(value, buffer)
    index_value = ROMAN_VALUES.index(value)
    if buffer.size <= 0
      true
    else
      last_number_bufer = buffer.last
      index_last_token = ROMAN_VALUES.index(last_number_bufer.value)
      if index_last_token > index_value
        true
      elsif index_last_token < index_value
        index_last_token + 1 == index_value
      else
        last_numbers = buffer.last(3)
        if last_numbers.size < 3
          true
        else
          last_numbers.uniq.size > 1
        end
      end
    end
  end

  def self.roman?(value)
    ROMAN_VALUES.include?(value)
  end
end
