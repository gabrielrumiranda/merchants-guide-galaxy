require_relative './parser'
require_relative './input_repository.rb'
#
class Calculator
  attr_reader :parser, :path

  def initialize(parser: Parser.new, repository: InputRepository.new)
    @parser = parser
    @repository = repository
    @parsed_lines = []
  end

  def calculate
    @repository.read.each do |file_line|
      @parsed_lines << @parser.parse(file_line)
    end
  end

  def print
    @repository.read.zip(@parsed_lines).each do |file_line, parsed_line|
      puts file_line
      puts parsed_line
    end
  end
end
