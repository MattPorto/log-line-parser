# frozen_string_literal: true

require_relative 'line'

module DataExtractors
  # module responsible to handle file content extractor methods
  module Base
    include Line

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

    def empty_file_error
      add_error_base
      @result[:errors].push({ message: 'Please provide a file to be analysed.' })
    end
  end
end
