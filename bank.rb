#!/usr/bin/env ruby
require_relative 'card'
# Main class of bank functionality
class Bank
  FLOAT_COUNT = 2
  FEE_INDEX = 1
  LIMIT_INDEX = 2
  CARD_TYPES = {
    # format ['Name of provider', 'Fee in procents', 'Max Limit of use']
    0 => ['Visa', 5, -2000],
    1 => ['MasterCard', 3, 0]
  }.freeze
  attr_reader :cards

  def initialize
    # @cards = []
    @cards = {}
    @curent_card = 0
  end

  def self.card_fee(index)
    CARD_TYPES[index][Bank::FEE_INDEX]
  end

  def self.card_limit(index)
    CARD_TYPES[index][Bank::LIMIT_INDEX]
  end

  def new_card
    puts 'Выберите тип карты'
    CARD_TYPES.each do |key, value|
      print "#{key} = #{value[0]} (#{value[1]}%) "
    end
    puts "\n"
    @curent_card = Card.new(gets.to_i)
    @cards[@curent_card.id] = @curent_card
  end

  def print_balance
    puts "#{find_card_by_id.balance}$"
  end

  def fund
    find_card_by_id.add_funds(input_sum)
  end

  def pay
    find_card_by_id.pay(input_sum)
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
    @cards.each_with_index do |a, index|
      puts "#{index} - #{a[1].balance.round(Bank::FLOAT_COUNT)}$ \
           - #{CARD_TYPES[a[1].user_card_type][0]}\n"
    end
  end

  def find_card_by_id
    loop do
      puts 'Введите номер карты'
      @card_id = gets.chomp
      @cards[@card_id]
      break if @cards.key?(@card_id) # @card_number != -1
    end
    @cards[@card_id]
  end

  def input_sum
    loop do
      puts 'Введите сумму'
      @sum = gets.chomp
      break unless @sum.empty?
    end
    @sum.to_f.round(Bank::FLOAT_COUNT)
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
