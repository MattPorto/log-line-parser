#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/file_handler'
require 'optparse'

option_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: run.rb [options]'
  opts.on '-f', '--file_path=FILEPATH', 'Log file path to be parsed'
  opts.on '-t', '--hits', 'Show the total of hits on path (include repeated addresses)'
  opts.on '-u', '--uniques', 'Show only unique hits on path'
  opts.on '-a', '--all', 'Show unique hits and total hits on path'

  opts.on('-h', '--help', 'Show commands list') do
    puts opts
    exit
  end
end

options = {}
option_parser.parse!(into: options)
FileHandler.new(options).call
