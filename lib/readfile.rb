require 'strscan'

class ReadFile
  attr_reader :line
  def initialize(file)
    @file = file
    @line = []
  end

  def file_reader
    line = []
    File.open(@file, 'r') { |i| line = i.readlines.map(&:chomp)}
    @line = line.map { |i| StringScanner.new(i)}
  end
end