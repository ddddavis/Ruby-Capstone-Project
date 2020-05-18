require 'strscan'
require_relative 'readfile.rb'

module Logic
  def checks_strict(line)
    test = line.any? { |i| i.scan(/"use strict";/) }
    if_error(0, 1, 0, 0) if test == false
  end

  def checks_eq(line)
    line.each_with_index do |i, j|
      i.scan_until(/={3}/)
      test1 = i.matched
      i.scan_until(/!==/)
      test2 = i.matched
      i.scan_until(/==/)
      test3 = i.matched
      i.scan_until(/!=/)
      test4 = i.matched
      next if test1 == '===' || test2 == '!=='

      if_error(j + 1, 2, '===', '==') if test3 == '=='
      if_error(j + 1, 2, '!==', '!=') if test4 == '!='
    end
  end

  def checks_var(line)
    line.each_with_index do |i, j|
      test = i.exist?(/\bvar\b/)
      if_error(j + 1, 3, 'var', 0) if test.is_a?(Integer)
    end
  end

  def checks_spacing(line)
    line.each_with_index do |i, j|
      if i.exist?(/{/)
        if_error(j + 1, 5, '{', 0) unless i.string.include?(' {')
      end
      if i.exist?(/}/)
        next if i.string.length == 1

        if_error(j + 1, 4, '}', 0) unless i.string.include?('} ')
      end
      if i.string.match?(/^[^=]*=[^=]*$/)
        next if i.string.include?('!=')

        if_error(j + 1, 6, '=', 0) unless i.string.include?(' = ')
      end
      if i.exist?(/\bif\b/)
        if_error(j + 1, 4, 'if', 0) unless i.string.include?('if ')
      end
      if i.exist?(/\belse if\b/)
        if_error(j + 1, 6, 'else if', 0) unless i.string.include?(' else if ')
      elsif i.exist?(/\belse\b/)
        if_error(j + 1, 6, 'else', 0) unless i.string.include?(' else ')
      end
    end
  end

  def checks_eol(line)
    if_error(line.index(line[-1]), 7, 'newline', 0) unless line[-1].string.empty?
  end

  def if_error(line, type, char1, char2)
    case type
    when 1
      puts 'Missing "use strict"; statement.'
    when 2
      puts "In line #{line}: Expected '#{char1}', got '#{char2}'"
    when 3
      puts "In line #{line}: Expected 'let' or 'const', got '#{char1}'"
    when 4
      puts "In line #{line}: Expected space after '#{char1}'"
    when 5
      puts "In line #{line}: Expected space before '#{char1}'"
    when 6
      puts "In line #{line}: Expected space before and after '#{char1}'"
    when 7
      puts "In line #{line}: Expected #{char1} at the end of file"
    end
  end
end
