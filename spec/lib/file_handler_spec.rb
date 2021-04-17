# frozen_string_literal: true

require 'spec_helper'
require 'file_handler'

describe FileHandler do
  it 'init' do
    log_path = 'spec/fixtures/basic.log'
    options = { file_path: log_path }

    result = described_class.new(options).call

    expect(result.keys).to eq %w[/help_page/1 /contact /home]
    expect(result['/help_page/1'][:hits]).to eq 1
  end
end
