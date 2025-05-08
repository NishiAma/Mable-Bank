class Transaction
  attr_reader :from_acc, :to_acc, :amount

  def initialize(from_acc:, to_acc:, amount:)
    @from_acc = from_acc
    @to_acc = to_acc
    @amount = amount.to_f
  end
end
