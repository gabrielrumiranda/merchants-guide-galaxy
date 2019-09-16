# frozen_string_literal: true

class InputRepository
  def initialize(path = '')
    @path = path
  end

  def read
    return [] unless File.file?(@path)

    File.read(@path).split(/\n/).compact
  end
end
