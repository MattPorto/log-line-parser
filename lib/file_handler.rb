# frozen_string_literal: true

require_relative 'data_extractors/base'

# class responsible to handle file analyse flow
class FileHandler
  include ::DataExtractors::Base

  def initialize(options)
    @file_path = options[:file_path]
    @result = {}
    @ip_records = {}
  end

  def call
    file = file_accessor
    extract_content file unless file_has_errors
    @result
  end

  private

  def add_error_base
    @result[:errors] ||= []
  end

  def file_has_errors
    @result.keys.include? :errors
  end
end
