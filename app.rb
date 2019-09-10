require_relative './app/calculator.rb'

calculator = Calculator.new('spec/files_spec/test.txt')
calculator.calculate
calculator.print
