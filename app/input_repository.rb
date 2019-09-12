class InputRepository

  def initialize(path = '')
    @path = File.file?(path) ? path : ''
  end

  def read
    File.read(@path).split(/\n/).compact

  rescue StandardError => error
    puts 'Is not possible read this file!'
  end
end
