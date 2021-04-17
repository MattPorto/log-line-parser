# frozen_string_literal: true

module DataExtractors
  # responsible to handle line content extractor methods
  module Line
    # require 'resolv' (see valid_ip_address method)

    def valid_data(line)
      # @ToDo: add line index arg, so the system can specify which line is with error;
      if line.gsub("\n", '').empty?
        empty_line_error
      elsif !valid_format(line) then malformed_line_error
      else true
      end
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

    def valid_format(line)
      line.count(' ').eql?(1) && valid_ip_address(line.split(' ').last)
    end

    def valid_ip_address(ip)
      # ip_format_regex = Regexp.union Resolv::IPv4::Regex, Resolv::IPv6::Regex (for real ip addresses)
      ip_format_regex = /(\d{1,3}\.?){4}/
      ip.match? ip_format_regex
    end

    def malformed_line_error
      add_error_base
      @result[:errors].push({ message: 'File have malformed lines.' })
    end
  end
end
