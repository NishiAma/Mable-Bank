require_relative '../lib/transaction'

RSpec.describe Transaction do
  let(:transaction) { Transaction.new(from_acc: '000001', to_acc: '000002', amount: 375.50) }

  it "initializes with correct attributes" do
    expect(transaction.from_acc).to eq('000001')
    expect(transaction.to_acc).to eq('000002')
    expect(transaction.amount).to eq(375.50)
  end
end
