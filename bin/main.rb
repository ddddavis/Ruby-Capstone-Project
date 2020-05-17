#!/usr/bin/env ruby

require_relative '../lib/readfile.rb'
require_relative '../lib/logic.rb'
# rubocop: disable Style/MixinUsage
include Logic

file = ARGF.argv[0]

if file
  doc = ReadFile.new(file)
  checks_strict(doc.file_reader)
  checks_eq(doc.file_reader)
  checks_var(doc.file_reader)
  checks_spacing(doc.file_reader)
  checks_eol(doc.file_reader)
else
  puts 'File name is required!'
end
# rubocop: enable Style/MixinUsage
