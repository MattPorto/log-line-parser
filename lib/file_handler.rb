# frozen_string_literal: true

require_relative 'data_extractors/base'

# class responsible to handle file analyse flow
class FileHandler
  include ::DataExtractors::Base

  def initialize(options)
    @options = options
    @file_path = options[:file_path]
    @result = {}
    @ip_records = {}
  end

  def call
    file = file_accessor
    extract_content file unless file_has_errors
    handle_response
    @result
  end

  private

  attr_reader :options

  def add_error_base
    @result[:errors] ||= []
  end

  def file_has_errors
    @result.keys.include? :errors
  end

  def handle_response
    return nil if file_has_errors

    if options[:hits]
      result_printer content: :hits
    elsif options[:uniques]
      result_printer content: :uniques
    else
      result_printer
    end
  end

  def result_printer(content: :default)
    case content
    when :hits
      @result.each { |_k, r| puts "#{r[:path]} #{r[:hits]} hit(s)" }
    when :uniques
      @result.each { |_k, r| puts "#{r[:path]} #{r[:uniques]} unique(s)" }
    else
      @result.each { |_k, r| puts "#{r[:path]} #{r[:hits]} hit(s), #{r[:uniques]} unique(s)" }
    end
  end
end
