# frozen_string_literal: true

require_relative './app/calculator'
require_relative './app/input_repository'

repository = InputRepository.new
repository.read_user_input
calculator = Calculator.new(repository: repository)
calculator.calculate!
calculator.print
