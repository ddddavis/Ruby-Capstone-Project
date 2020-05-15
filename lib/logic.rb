require 'strscan'
require_relative 'readfile.rb'

module Logic
  def checksIfUseStrict(line)
    test = line.any? { |i| i.scan(/"use strict";/) }
    ifError(0, 1, 0, 0) if test == false
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
        ifError(j + 1, 2, '===', '==')
      elsif test4 == '!='
        ifError(j + 1, 2, '!==', '!=')
      end
    end
  end

  def checksIfVar(line)
    line.each_with_index do |i, j|
      test = i.exist?(/\bvar\b/)
      ifError(j + 1, 4, 'var', 0) if test.is_a?(Integer)
    end
  end

  def checksSpacing(line)
    line.each_with_index do |i, j|
      if i.exist?(/{/)
        ifError(j + 1, 5, '{', 0) unless i.string.include?(' {')
      end
      if i.exist?(/}/)
        if i.string.length == 1
          next
        elsif !i.string.include?('} ')
          ifError(j + 1, 4, '}', 0)
        end
      end
      if i.string.match?(/^[^=]*=[^=]*$/)
        next if i.string.include?('!=')

        ifError(j + 1, 6, '=', 0) unless i.string.include?(' = ')
      end
      if i.exist?(/\bif\b/)
        ifError(j + 1, 4, 'if', 0) unless i.string.include?('if ')
      end
      if i.exist?(/\belse if\b/)
        ifError(j + 1, 6, 'else if', 0) unless i.string.include?(' else if ')
      elsif i.exist?(/\belse\b/)
        ifError(j + 1, 6, 'else', 0) unless i.string.include?(' else ')
      end
    end
  end

  def checksEOL(line)
    ifError(line.index(line[-1]), 7, 'newline', 0) unless line[-1].string.empty?
  end

  def ifError(l, type, char1, char2)
    case type
    when 1
      puts 'Missing "use strict"; statement.'
    when 2
      puts "In line #{l}: Expected '#{char1}', got '#{char2}'"
    when 3
      puts "In line #{l}: Expected 'let' or 'const', got '#{char1}'"
    when 4
      puts "In line #{l}: Expected space after '#{char1}'"
    when 5
      puts "In line #{l}: Expected space before '#{char1}'"
    when 6
      puts "In line #{l}: Expected space before and after '#{char1}'"
    when 7
      puts "In line #{l}: Expected #{char1} at the end of file"
    end
  end
end
