class TokenValidator 
  ROMAN_VALUES = [1, 5, 10, 50, 100, 500, 1000].freeze

  def self.valid_push?(token, buffer)
    return true unless roman?(token.value)

    valid_roman_precedence?(token.value, buffer)
  end

  def self.valid_roman_precedence?(value, buffer)
    index_value = ROMAN_VALUES.index(value)
    return true if buffer.size <= 0

    last_number_bufer = buffer.last
    index_last_token = ROMAN_VALUES.index(last_number_bufer.value)
    return true if index_last_token > index_value

    return index_last_token + 1 == index_value if index_last_token < index_value

    last_numbers = buffer.last(3)
    return true if last_numbers.size < 3

    return last_numbers.uniq.size > 1 if last_numbers.size >= 3
  end

  def self.roman?(value)
    ROMAN_VALUES.include?(value)
  end
end
