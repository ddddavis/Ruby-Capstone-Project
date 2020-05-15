#!/usr/bin/env ruby

require_relative '../lib/readfile.rb'
require_relative '../lib/logic.rb'
# rubocop: disable Style/MixinUsage
include Logic

file = ARGF.argv[0]

if file
  doc = ReadFile.new(file)
  checksIfUseStrict(doc.file_reader)
  checksIfEq(doc.file_reader)
  checksIfVar(doc.file_reader)
  checksSpacing(doc.file_reader)
else
  puts 'File name is required!'
end
# rubocop: enable Style/MixinUsage
