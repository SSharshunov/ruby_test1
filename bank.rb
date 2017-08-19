#!/usr/bin/env ruby
require_relative 'card'
class Bank
  attr_reader :cards
  
  def initialize
    @cardTypes = ["Visa", "MasterCard"]
    @cards = Array.new
    @curentCard = 0
  end
  
  def newCard
    puts "Выберите тип карты " 
    @cardTypes.each_with_index { |c, index| print "#{index} = #{c} " }
    puts "\n"
    userCardType = gets().to_i
    @curentCard = Card.new(userCardType)
    @cards.push(@curentCard)
    puts "На данный момент открыто #{@cards.count} карт(ы)\n" 
  end
  
  def getBalance 
    puts "$#{@cards[findCardById(@cardId)].balance}."
  end
  
  def fund  
    loop do 
      puts "Введите сумму " 
      @sum = gets.chomp
      
      break if !(@sum.empty?)
    end 
    @cards[findCardById(@cardId)].add_funds(@sum.to_i)
  end

  def pay
    loop do 
      puts "Введите сумму " 
      @sum = gets.chomp
      break if !(@sum.empty?)
    end 
    @cards[findCardById(@cardId)].pay(@sum.to_i)
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

  def printAllCards
    puts "На данный момент открыто #{@cards.count} карт(ы)\n"
    @cards.each { |a| puts "#{a.id.to_s} - $#{a.balance.to_s}.\n" }
  end
  
  def findCardById(cardId)
    loop do 
      @cardNumber = -1
      puts "Введите номер карты " 
      @cardId = gets.chomp
      
      @cards.each_with_index do |c, index|
        if c.id==@cardId
          @cardNumber = index
        end 
      end
      puts "-------------!#{@cardNumber}!----------------"
      break if @cardNumber != -1
    end
    return @cardNumber
  end
    
end

b = Bank.new()

loop do
  b.help
  input = gets.chomp
  command, *params = input.split /\s/
  case command
    when '0'
      puts b.newCard
    when '1'
      puts b.getBalance
    when '2'
      puts b.printAllCards
    when '3'
      puts b.fund
    when '4'
      puts b.pay
    else
      puts 'Неверная команда'
  end 
end
