#!/usr/bin/env ruby

class Card
  def initialize(userCardType = 0)
    @id = (0...8).map { (65 + rand(26)).chr }.join
    @userCardType = userCardType
    @balance = 0
    puts "Номер карты \"#{id}\""
  end
    
  def balance
    return @balance
  end
    
  def id
    return @id
  end
    
  def add_funds(sum)
    @balance = @balance + sum
  end

  def pay(sum)
    if @userCardType == (0)
      sum = sum * 0.05 + sum
      if balance-sum >= -2000
        @balance = @balance - sum
        puts "У вас списано #{sum}"
      else
        puts "У вас недостаточно средств на балансе"
      end
    elsif @userCardType == (1)
      sum = sum * 0.03 + sum
      if balance-sum >= 0
        @balance = @balance - sum
        puts "У вас списано #{sum}"
      else
        puts "У вас недостаточно средств на балансе"
      end
    end
  end
    
end
