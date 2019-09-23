# frozen_string_literal: true

class InputRepository
  def initialize(path = '')
    @path = path
  end

  def read_file
    return [] unless File.file?(@path)

    File.read(@path).split(/\n/).compact
  end

  def read_user_input
    puts 'Type the path of file who you want calculate'
    @path = gets.chomp
    read_file
  end
end
