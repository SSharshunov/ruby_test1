#!/usr/bin/env ruby
require_relative 'card'

# Main class of bank functionality
class Bank
  attr_reader :cards

  def initialize
    @card_types = %w[Visa MasterCard]
    @cards = []
    @curent_card = 0
  end

  def new_card
    puts 'Выберите тип карты'
    @card_types.each_with_index { |c, index| print "#{index} = #{c} " }
    puts "\n"
    user_card_type = gets.to_i
    @curent_card = Card.new(user_card_type)
    @cards.push(@curent_card)
    puts "На данный момент открыто #{@cards.count} карт(ы)\n"
  end

  def print_balance
    puts "$#{@cards[find_card_by_id].balance}."
  end

  def fund
    loop do
      puts 'Введите сумму'
      @sum = gets.chomp
      break unless @sum.empty?
    end
    @cards[find_card_by_id].add_funds(@sum.to_i)
  end

  def pay
    loop do
      puts 'Введите сумму'
      @sum = gets.chomp
      break unless @sum.empty?
    end
    @cards[find_card_by_id].pay(@sum.to_i)
  end

  def help
    puts "Добро пожаловать в наш Банк\n" \
     "На данный момент открыто #{@cards.count} карт(ы)\n" \
     "0 - Открытие новой карты\n" \
     "1 - Узнать баланс\n" \
     "2 - Вывести все карты\n" \
     "3 - Пополнить баланс\n" \
     "4 - Оплатить\n" \
  end

  def print_all_cards
    puts "На данный момент открыто #{@cards.count} карт(ы)\n"
    @cards.each { |a| puts "#{a.id} - $#{a.balance}.\n" }
  end

  def find_card_by_id
    loop do
      @card_number = -1
      puts 'Введите номер карты'
      @card_id = gets.chomp
      @cards.each_with_index do |c, index|
        @card_number = index if c.id == @card_id
      end
      break if @card_number != -1
    end
    @card_number
  end
end

b = Bank.new

loop do
  b.help
  command = gets.chomp
  case command
  when '0'
    puts b.new_card
  when '1'
    puts b.print_balance
  when '2'
    puts b.print_all_cards
  when '3'
    puts b.fund
  when '4'
    puts b.pay
  else
    puts 'Неверная команда'
  end
end
