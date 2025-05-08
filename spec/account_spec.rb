require_relative '../lib/account'

RSpec.describe Account do
  let(:account) { Account.new(id: '0000000000000001', balance: 500.0) }

  it "initializes with correct ID and balance" do
    expect(account.id).to eq('0000000000000001')
    expect(account.balance).to eq(500.0)
  end

  it "debits balance when sufficient funds are available" do
    account.debit(300.0)
    expect(account.balance).to eq(200.0)
  end

  it "raises error when trying to debit more than balance" do
    expect { account.debit(700.0) }.to raise_error("Insufficient amount")
  end

  it "credits balance correctly" do
    account.credit(250.0)
    expect(account.balance).to eq(750.0)
  end
end
