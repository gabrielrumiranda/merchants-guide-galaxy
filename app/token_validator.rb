# frozen_string_literal: true

class TokenValidator
  ROMAN_VALUES = [1, 5, 10, 50, 100, 500, 1000].freeze

  class << self
    def valid_token_push?(token, buffer)
      return true unless roman?(token.value)

      valid_roman_precedence?(token.value, buffer)
    end

    def valid_roman_precedence?(value, buffer)
      return true if buffer.size <= 0

      index_value = ROMAN_VALUES.index(value)
      last_number_bufer = buffer.last
      last_index = ROMAN_VALUES.index(last_number_bufer.value)
      return true if last_index > index_value

      return last_index + 1 == index_value if last_index < index_value

      valid_three_number_rule?(buffer)
    end

    def roman?(value)
      ROMAN_VALUES.include?(value)
    end

    def valid_three_number_rule?(buffer)
      last_numbers = buffer.last(3)
      return true if last_numbers.size < 3

      last_numbers.uniq.size > 1
    end
  end
end
