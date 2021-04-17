# frozen_string_literal: true

require 'spec_helper'
require 'file_handler'

describe 'FileHandler - Validations' do
  let(:basic_log_path) { 'spec/fixtures/basic.log' }
  let(:complex_log_path) { 'spec/fixtures/webserver.log' }
  subject(:options) { { file_path: log_path } }
  subject(:call_scope) { FileHandler.new(options).call }
  subject(:result) { call_scope }

  context 'with a simple file' do
    let(:log_path) { basic_log_path }
    subject(:result_first) { result['/help_page/1'] }

    it 'collect data' do
      expect(result_first[:hits]).to eq 3
      expect(result_first[:uniques]).to eq 1
    end
  end

  context 'with a complex file' do
    let(:log_path) { complex_log_path }
    subject(:result_home) { result['/home'] }

    it 'collect data' do
      expect(result_home[:hits]).to eq 78
      expect(result_home[:uniques]).to eq 23
    end
  end
end
