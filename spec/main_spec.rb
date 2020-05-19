require_relative '../lib/logic.rb'
require_relative '../lib/readfile.rb'
require_relative './spec_helper.rb'

# rubocop: disable Layout/LineLength

RSpec.describe Logic do
  include Logic

  let(:file_location) { 'bin/rspec_test.js' }

  describe '#checks_readfile' do
    it 'should return an instance of StringScanner from readfile' do
      string = ReadFile.new(file_location)
      expect(string.file_reader.shift).to be_a(StringScanner)
    end
  end

  describe '#checks_strict' do
    it 'should check if "use strict"; statement is used at all' do
      string = ReadFile.new(file_location)
      expect { checks_strict(string.file_reader) }.to output("Missing \"use strict\"; statement.\n").to_stdout
    end
  end

  describe '#checks_relation_operator' do
    it 'should check if the correct relation operator "===" is used' do
      string = ReadFile.new(file_location)
      expect { checks_relation_operator(string.file_reader) }.to output("In line \e[34m2\e[0m: Use \e[32m'==='\e[0m, instead of \e[31m'=='\e[0m.\n").to_stdout
    end
  end

  describe '#checks_var' do
    it 'should check if the correct variable decleration is used' do
      string = ReadFile.new(file_location)
      expect { checks_var(string.file_reader) }.to output("In line \e[34m3\e[0m: Use \e[32m'let'\e[0m or \e[32m'const'\e[0m, instead of \e[31m'var'\e[0m.\n").to_stdout
    end
  end

  describe '#checks_spacing' do
    it 'should check if the correct spacing is used' do
      string = ReadFile.new(file_location)
      expect { checks_spacing(string.file_reader) }.to output("In line \e[34m3\e[0m: Space expected before and after \e[32m'='\e[0m.\n").to_stdout
    end
  end

  describe '#checks_eol' do
    it 'should check if there is new line at the end of file' do
      string = ReadFile.new(file_location)
      expect { checks_eol(string.file_reader) }.to output("In line \e[34m2\e[0m: Expected \e[32m'newline'\e[0m at the end of file.\n").to_stdout
    end
  end
end
# rubocop: enable Layout/LineLength
