class Account
  attr_reader :id
  attr_accessor :balance

  def initialize(id:, balance:)
    @id = id
    @balance = balance.to_f
  end

  def debit(amount)
    raise "Insufficient amount" if @balance < amount
    @balance -= amount
  end

  def credit(amount)
    @balance += amount
  end
end
