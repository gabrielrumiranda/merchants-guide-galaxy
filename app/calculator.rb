# frozen_string_literal: true

require_relative './parser'
require_relative './input_repository'

class Calculator
  def initialize(parser: Parser.new, repository: InputRepository.new)
    @parser = parser
    @repository = repository
    @parsed_lines = []
    @file_lines = @repository.read_file
  end

  def calculate!
    @parsed_lines = @file_lines.map(&@parser.method(:parse!)) if @file_lines
  end

  def print
    @file_lines.zip(@parsed_lines).each do |file_line, parsed_line|
      puts file_line
      puts parsed_line
    end
  end
end
