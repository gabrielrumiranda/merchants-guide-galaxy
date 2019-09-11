class InputRepository

  def initialize(path = '')
    @path = File.file?(path) ? path : ''
  end

  def read
    file_lines = []
    IO.foreach(@path) do |file_line|
      next if file_line.nil? || file_line.empty?

      file_lines << file_line
    end
    file_lines
  end
end
