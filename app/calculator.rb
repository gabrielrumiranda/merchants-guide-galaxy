require_relative './parser'
#
class Calculator

  attr_reader :parser, :path
  def initialize(path)
    @parser = Parser.new
    @path = File.join(File.dirname(__FILE__), path)
    @parsed_lines = []
    @file_lines = []
  end

  def read
    IO.foreach(@path) do |file_line|
      @file_lines << file_line
      unless file_line.nil? && file_line.empty?
        @parsed_lines << @parser.parse(file_line)
      end
    end
  end

  def print
    @file_lines.zip(@parsed_lines).each do |file_line, parsed_line|
      puts file_line
      puts parsed_line
    end
  end
end
