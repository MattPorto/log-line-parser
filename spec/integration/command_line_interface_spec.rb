# frozen_string_literal: true

require 'spec_helper'
require 'open3' # to capture cli interactions

describe 'command line interface' do
  subject(:command) { './run.rb' }

  context 'flags' do
    it 'help' do
      stdout, _stderr, _status = Open3.capture2 command, '-h'
      parsed_stdout = stdout.split("\n")
      commands_list = [
        '    -f, --file                       LogFile to be parsed',
        '    -t, --total                      Show the total of hits on path (include repeated addresses)',
        '    -u, --uniques                    Show only unique hits on path',
        '    -a, --all                        Show unique hits and total hits on path',
        '    -h, --help                       Show commands list'
      ]

      expect(parsed_stdout[1..parsed_stdout.size]).to eq commands_list
    end
  end
end
