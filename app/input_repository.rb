# frozen_string_literal: true

class InputRepository
  def initialize(path = '')
    @path = File.file?(path) ? path : ''
  end

  def read
    File.read(@path).split(/\n/).compact
  rescue StandardError
    puts "It's not possible"
  end
end
