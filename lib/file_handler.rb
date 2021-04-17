# frozen_string_literal: true

# class responsible to handle file analyse flow
class FileHandler
  def initialize(options)
    @file_path = options[:file_path]
  end

  def call
    file = File.read @file_path
    result = {}

    file.each_line do |line|
      path, _ip = line.split(' ')
      result[path] ||= { path: path, hits: 0, uniques: 0 }
      result[path][:hits] += 1
    end

    result
  end
end
