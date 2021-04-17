# frozen_string_literal: true

module DataExtractors
  # responsible to handle line content extractor methods
  module Line
    def valid_data(line)
      # @ToDo: add line index arg, so system can specify which line is empty;
      #   add also malformed log lines checker
      parsed_line = line.gsub("\n", '')
      parsed_line.empty? ? empty_line_error : true
    end

    def extract_data(line)
      path, ip = line.split ' '
      add_path_to_result path
      increment_hits path
      increment_uniques path, ip
    end

    def empty_line_error
      add_error_base
      @result[:errors].push({ message: 'File have empty lines.' })
    end

    def add_path_to_result(path)
      @result[path] ||= { path: path, hits: 0, uniques: 0 }
    end

    def increment_hits(path)
      @result[path][:hits] += 1
    end

    def increment_uniques(path, ip)
      @result[path][:uniques] += 1 if check_uniqueness path, ip
    end

    def check_uniqueness(path, ip)
      @ip_records[path] ||= []
      @ip_records[path].include?(ip) ? false : add_ip_to_records(path, ip)
    end

    def add_ip_to_records(path, ip)
      @ip_records[path].push ip
      true
    end
  end
end
