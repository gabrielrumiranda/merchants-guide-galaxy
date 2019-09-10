class InputRepository
  attr_accessor :file_lines, :path

  def initialize(path = '')
    unless path.nil? || path.empty?
      @path = File.join(File.dirname(__FILE__), path)
    end
    @file_lines = []
  end

  def read
    IO.foreach(@path) do |file_line|
      next if file_line.nil? || file_line.empty?

      @file_lines << file_line
    end
  end

  def set_path(path)
    if File.file?(path) && File.exist?(path)
      @path = path
    else
      puts 'Invalid path'
      @path = ''
    end
  end
end
