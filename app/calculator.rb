require_relative './parser'
require_relative './input_repository.rb'
#
class Calculator
  attr_reader :parser, :path

  def initialize(path)
    @parser = Parser.new
    @repository = InputRepository.new
    @repository.set_path(path)
    @parsed_lines = []
  end

  def calculate
    @repository.read
    @repository.file_lines.each do |file_line|
      @parsed_lines << @parser.parse(file_line)
    end
  end

  def print
    @repository.file_lines.zip(@parsed_lines).each do |file_line, parsed_line|
      puts file_line
      puts parsed_line
    end
  end
end
