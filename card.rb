# Class of cards functionality
class Card
  attr_reader :balance, :id
  def initialize(userCardType = 0)
    @id = (0...8).map { (65 + rand(26)).chr }.join
    @user_card_type = userCardType
    @balance = 0
    puts "Номер карты \"#{id}\""
  end

  def add_funds(sum)
    @balance += sum
  end

  def pay(sum)
    start_balance = @balance
    @user_card_type.zero? ? (sum = sum * 0.05 + sum) : (sum = sum * 0.03 + sum)
    @user_card_type.zero? ? (over_balance = -2000) : (over_balance = 0)
    @balance -= sum if @balance - sum >= over_balance
    puts "У вас списано #{@balance - start_balance}"
    puts 'Недостаточно средств' if start_balance == @balance
  end
end
