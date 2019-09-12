require_relative './app/calculator'
require_relative './app/input_repository'

repository = InputRepository.new('spec/files_spec/test.txt')
calculator = Calculator.new(repository: repository)
calculator.calculate!
calculator.print
