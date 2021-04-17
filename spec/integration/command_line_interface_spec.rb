# frozen_string_literal: true

require 'spec_helper'
require 'open3' # to capture cli interactions

describe 'command line interface' do
  subject(:command) { './run.rb' }
  let(:log_file) { 'spec/fixtures/basic.log' }
  let(:parsed_stdout) { stdout.split("\n") }

  context 'help' do
    let(:stdout) { Open3.capture2(command, '-h')[0] }
    let!(:commands_list) do
      ['    -f, --file_path=FILEPATH         Log file path to be parsed',
       '    -t, --hits                       Show the total of hits on path (include repeated addresses)',
       '    -u, --uniques                    Show only unique hits on path',
       '    -a, --all                        Show unique hits and total hits on path',
       '    -h, --help                       Show commands list']
    end
    subject { parsed_stdout[1..parsed_stdout.size] }
    it { is_expected.to eq commands_list }
  end
end
