# frozen_string_literal: true

require 'spec_helper'
require 'file_handler'

describe FileHandler do
  let(:basic_log_path) { 'spec/fixtures/basic.log' }
  subject(:options) { { file_path: log_path } }

  context 'data collect' do
    let(:log_path) { basic_log_path }

    it 'get hits' do
      result = described_class.new(options).call

      expect(result.keys).to eq %w[/help_page/1 /contact /home]
      expect(result['/help_page/1'][:hits]).to eq 1
    end
  end
end
