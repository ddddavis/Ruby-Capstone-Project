require 'strscan'
require_relative 'readfile.rb'

module Logic
  def checksIfUseStrict(line)
    test = line.any? { |i| i.scan(/"use strict";/)}
    if test == false
      ifError(0, 1)
    end
  end

  def checksIfEq(line)
    line.each_with_index do |i, j|
      i.scan_until(/={3}/)
      test1 = i.matched
      i.scan_until(/!==/)
      test2 = i.matched
      i.scan_until(/==/)
      test3 = i.matched
      i.scan_until(/!=/)
      test4 = i.matched
      if test1 == '===' || test2 == '!=='
        next
      elsif test3 == '=='
        ifError(j+1, 2)
      elsif test4 == '!='
        ifError(j+1, 3)
      end
    end
  end

  def checksIfVar(line)
    line.each_with_index do |i, j|
      test = i.exist?(/\bvar\b/)
      ifError(j+1, 4) if test.is_a?(Integer)
    end
  end

  def checksSpacing(line)
    line.each_with_index do |i, j|
      i.scan_until(/\s(?=[^{\s]*{)/)
      test = i.matched
      if !test.nil?
        ifError(j+1, 6)
      end
    end
  end

  def ifError(l, type)
    case type
    when 1
      puts "Missing \"use strict\"; statement."
    when 2
      puts "In line #{l}: Expected '===' instead of '=='"
    when 3
      puts "In line #{l}: Expected '!==' instead of '!='"
    when 4
      puts "In line #{l}: Expected 'let' or 'const' instead of 'var'"
    when 5
      puts "In line #{l}: Expected space after '}'"
    when 6
      puts "In line #{l}: Expected space before {"
    end
  end

 # def checksEq(line)
 #   line.each do |i|
 #     i.match?("==")
 #     puts i.matched?
 #   end
 # end
end