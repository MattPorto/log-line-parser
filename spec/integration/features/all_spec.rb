# frozen_string_literal: true

require 'spec_helper'
require 'open3' # to capture cli interactions

describe 'features - all' do
  subject(:command) { './run.rb' }
  let(:log_file) { 'spec/fixtures/basic.log' }
  let(:parsed_stdout) { stdout.split("\n") }
  subject { parsed_stdout }
  let(:stdout) { Open3.capture2(command, "-f#{log_file}", '-a')[0] }
  let!(:expected_result) do
    ['/help_page/1 3 hit(s), 1 unique(s)', '/home 1 hit(s), 1 unique(s)', '/contact 1 hit(s), 1 unique(s)']
  end

  it { is_expected.to eq expected_result }
end
