# frozen_string_literal: true

module DataExtractors
  # responsible to handle line content extractor methods
  module Line
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

    def empty_line_error
      add_error_base
      @result[:errors].push({ message: 'File have empty lines.' })
    end
  end
end
