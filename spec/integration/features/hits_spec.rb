# frozen_string_literal: true

require 'spec_helper'
require 'open3' # to capture cli interactions

describe 'features - hits' do
  subject(:command) { './run.rb' }
  let(:log_file) { 'spec/fixtures/basic.log' }
  let(:parsed_stdout) { stdout.split("\n") }
  subject { parsed_stdout }
  let(:stdout) { Open3.capture2(command, "-f#{log_file}", '-t')[0] }
  let!(:expected_result) { ['/help_page/1 3 hit(s)', '/home 1 hit(s)', '/contact 1 hit(s)'] }

  it { is_expected.to eq expected_result }
end
