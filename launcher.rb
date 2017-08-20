#!/usr/bin/env ruby
# Launcher
class Launcher
  def initialize
    require_relative @class.capitalize
  end
  @class = ARGV[0]
  ARGV.clear
  require_relative @class
  t = const_get(@class.capitalize)

  r = t.new
  loop do
    t.helper.each do |a|
      print "#{a[0]} - #{a[1][0]} - #{a[1][1]}\n"
    end
    loop do
      puts 'Введите номер команды'
      @command = gets.chomp.to_i
      break unless @command >= t.helper.count
    end
    r.public_send(t.helper[@command][1]) if r.respond_to? t.helper[@command][1]
  end
end
