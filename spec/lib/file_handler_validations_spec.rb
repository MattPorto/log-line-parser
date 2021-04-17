# frozen_string_literal: true

require 'spec_helper'
require 'file_handler'

# A extension of file handler spec that handle error scenarios
describe 'FileHandler - Validations' do
  let(:basic_log_path) { 'spec/fixtures/basic.log' }
  subject(:options) { { file_path: '' } }
  subject(:call_scope) { FileHandler.new(options).call }
  subject(:result) { call_scope }

  context 'validations' do
    subject(:first_error) { result[:errors][0] }

    it 'no filepath' do
      expect(first_error[:message]).to eq 'Please provide a file to be analysed.'
    end

    it 'empty file' do
      options[:file_path] = 'spec/fixtures/empty.log'
      expect(first_error[:message]).to eq 'File is empty.'
    end

    it 'empty lines' do
      options[:file_path] = 'spec/fixtures/with-empty-lines.log'
      expect(first_error[:message]).to eq 'File have empty lines.'
    end

    it 'malformed lines' do
      options[:file_path] = 'spec/fixtures/malformed-lines.log'
      expect(first_error[:message]).to eq 'File have malformed lines.'
    end
  end
end
