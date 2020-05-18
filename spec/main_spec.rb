require_relative '../lib/logic.rb'
require_relative '../lib/readfile.rb'
require_relative './spec_helper.rb'

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
      expect { checks_strict(string.file_reader) }.to
      output("Missing \"use strict\"; statement.\n").to_stdout
    end
  end

  describe '#checks_relation_operator' do
    it 'should check if the correct relation operator "===" is used' do
      string = ReadFile.new(file_location)
      expect { checks_relation_operator(string.file_reader) }.to
      output("In line 2: Expected '===', got '=='.\n").to_stdout
    end
  end

  describe '#checks_var' do
    it 'should check if the correct variable decleration is used' do
      string = ReadFile.new(file_location)
      expect { checks_var(string.file_reader) }.to
      output("In line 3: Expected 'let' or 'const', got 'var'.\n").to_stdout
    end
  end

  describe '#checks_spacing' do
    it 'should check if the correct spacing is used' do
      string = ReadFile.new(file_location)
      expect { checks_spacing(string.file_reader) }.to
      output("In line 3: Expected space before and after '='.\n").to_stdout
    end
  end

  describe '#checks_eol' do
    it 'should check if there is new line at the end of file' do
      string = ReadFile.new(file_location)
      expect { checks_eol(string.file_reader) }.to
      output("In line 2: Expected newline at the end of file.\n").to_stdout
    end
  end
end
