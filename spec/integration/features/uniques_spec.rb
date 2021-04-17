# frozen_string_literal: true

require 'spec_helper'
require 'open3' # to capture cli interactions

describe 'features - uniques' do
  subject(:command) { './run.rb' }
  let(:log_file) { 'spec/fixtures/basic.log' }
  let(:parsed_stdout) { stdout.split("\n") }

  subject { parsed_stdout }

  let(:stdout) { Open3.capture2(command, "-f#{log_file}", '-u')[0] }
  let!(:expected_result) { ['/help_page/1 1 unique(s)', '/contact 1 unique(s)', '/home 1 unique(s)'] }

  it { is_expected.to eq expected_result }
end
