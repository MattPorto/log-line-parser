# frozen_string_literal: true

# class responsible to handle file analyse flow
class FileHandler
  def initialize(options)
    @file_path = options[:file_path]
    @result = {}
  end

  def call
    file = file_accessor
    extract_content file unless file_has_errors
    @result
  end

  private

  def file_by_path
    File.read @file_path if File.exist? @file_path
  end

  def file_accessor
    file = file_by_path
    file.nil? ? empty_file_error : file
  end

  def extract_content(file)
    file.each_line { |line| extract_data line if valid_data line }
  end

  def valid_data(line)
    # @ToDo: add line index arg, so system can specify which line is empty;
    #   add also malformed log lines checker
    line.empty? ? empty_line_error : true
  end

  def extract_data(line)
    path, _ip = line.split(' ')
    @result[path] ||= { path: path, hits: 0, uniques: 0 }
    @result[path][:hits] += 1
  end

  def empty_file_error
    add_error_base
    @result[:errors].push({ message: 'Please provide a file to be analysed.' })
  end

  def empty_line_error
    add_error_base
    @result[:errors].push({ message: 'File have empty lines.' })
  end

  def add_error_base
    @result[:errors] ||= []
  end

  def file_has_errors
    @result.keys.include? :errors
  end
end
