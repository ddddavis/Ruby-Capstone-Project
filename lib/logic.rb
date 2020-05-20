require 'strscan'
require_relative 'readfile.rb'
# rubocop: disable Metrics/CyclomaticComplexity, Style/GuardClause
module Logic
  def checks_strict(line)
    test = line.any? { |i| i.scan(/"use strict";/) }
    if_error(0, 1, 0, 0) if test == false
  end

  def checks_relation_operator(line)
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

  def checks_spacing_before(ele, iii, type, char)
    if ele.exist?(Regexp.new(char))
      if_error(iii + 1, type, char, 0) unless ele.string.include?(" #{char}")
    end
  end

  def checks_spacing_after(ele, iii, type, char)
    if ele.exist?(Regexp.new(char))
      unless ele.string.length == 1
        if_error(iii + 1, type, char, 0) unless ele.string.include?("#{char} ")
      end
    end
  end

  def checks_spacing_before_after(ele, iii, type, char, str)
    if ele.string.match?(Regexp.new(char))
      unless ele.exist?(/\b^[^!=]*!=[^!=]*$\b/)
        if_error(iii + 1, type, str, 0) unless ele.string.include?(" #{str} ")
      end
    end
  end

  def checks_spacing(line)
    line.each_with_index do |i, j|
      checks_spacing_before(i, j, 5, '{')
      checks_spacing_after(i, j, 4, '}')
      checks_spacing_after(i, j, 4, 'if')
      checks_spacing_before_after(i, j, 6, '\\belse if\\b', 'else if')
      checks_spacing_before_after(i, j, 6, '\\belse\\b', 'else')
      checks_spacing_before_after(i, j, 6, '\\b===\\b', '===')
      checks_spacing_before_after(i, j, 6, '\\b!==\\b', '!==')
      checks_spacing_before_after(i, j, 6, '\\b^[^=]*=[^=]*$\\b', '=')
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
      puts "In line \e[34m#{line}\e[0m: Use \e[32m'#{char1}'\e[0m, instead of \e[31m'#{char2}'\e[0m."
    when 3
      puts "In line \e[34m#{line}\e[0m: Use \e[32m'let'\e[0m or \e[32m'const'\e[0m, instead of \e[31m'#{char1}'\e[0m."
    when 4
      puts "In line \e[34m#{line}\e[0m: Space expected after \e[32m'#{char1}'\e[0m."
    when 5
      puts "In line \e[34m#{line}\e[0m: Space expected before \e[32m'#{char1}'\e[0m."
    when 6
      puts "In line \e[34m#{line}\e[0m: Space expected before and after \e[32m'#{char1}'\e[0m."
    when 7
      puts "In line \e[34m#{line}\e[0m: Expected \e[32m'#{char1}'\e[0m at the end of file."
    end
  end
end
# rubocop: enable Metrics/CyclomaticComplexity, Style/GuardClause
