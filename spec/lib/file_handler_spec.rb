# frozen_string_literal: true

require 'spec_helper'
require 'file_handler'

describe FileHandler do
  let(:basic_log_path) { 'spec/fixtures/basic.log' }
  subject(:options) { { file_path: log_path } }
  subject(:call_scope) { described_class.new(options).call }
  subject(:result) { call_scope }

  context 'data collect' do
    let(:log_path) { basic_log_path }
    subject(:result_first) { result['/help_page/1'] }

    it 'hits' do
      expect(result_first[:hits]).to eq 3
    end

    it 'uniques' do
      expect(result_first[:uniques]).to eq 1
    end
  end

  context 'validations' do
    let(:log_path) { '' }
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
  end
end
