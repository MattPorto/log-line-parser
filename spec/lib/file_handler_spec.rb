# frozen_string_literal: true

require 'spec_helper'
require 'file_handler'

describe FileHandler do
  let(:basic_log_path) { 'spec/fixtures/basic.log' }
  subject(:options) { { file_path: log_path } }
  subject(:call_scope) { described_class.new(options).call }

  context 'data collect' do
    let(:log_path) { basic_log_path }

    it 'hits' do
      result = call_scope

      expect(result.keys).to eq %w[/help_page/1 /contact /home]
      expect(result['/help_page/1'][:hits]).to eq 3
    end

    it 'uniques' do
      result = call_scope
      first_key = result.keys.first

      expect(result[first_key][:uniques]).to eq 1
    end
  end

  context 'validations' do
    let(:log_path) { '' }

    it 'no filepath' do
      result = call_scope

      expect(result.keys).to include :errors
      expect(result[:errors][0][:message]).to eq 'Please provide a file to be analysed.'
    end

    it 'empty lines' do
      options[:file_path] = 'spec/fixtures/with-empty-lines.log'

      result = call_scope

      expect(result.keys).to include :errors
      expect(result[:errors][0][:message]).to eq 'File have empty lines.'
    end
  end
end
