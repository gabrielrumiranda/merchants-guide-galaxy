class InputRepository

  def initialize(path = '')
    @path = File.file?(path) ? path : ''
  end

  def read
    File.read(@path).split(/\n/).compact
  end
end
