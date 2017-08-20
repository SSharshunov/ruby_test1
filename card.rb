# Class of cards functionality
class Card
  MAX_RANDOM = 26
  SALT_RANDOM = 65
  START_BALANCE = 0.00
  attr_reader :balance, :id, :user_card_type
  def initialize(user_card_type = 0)
    @id = (0...8).map { (Card::SALT_RANDOM + rand(Card::MAX_RANDOM)).chr }.join
    @user_card_type = user_card_type
    @balance = Card::START_BALANCE
    puts "Номер карты \"#{id}\""
  end

  def add_funds(sum)
    @balance += sum.to_f
  end

  def pay(sum)
    start_balance = @balance
    sum += sum * Bank.card_fee(@user_card_type) / 100
    over_balance = Bank.card_limit(@user_card_type)
    @balance -= sum if @balance - sum >= over_balance
    puts "У вас списано #{@balance - start_balance}"
    puts 'Недостаточно средств' if start_balance == @balance
  end
end
