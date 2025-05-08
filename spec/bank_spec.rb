require 'bank'
require 'csv'

RSpec.describe Bank do
  let(:bank) { Bank.new }
  let(:accounts_csv) { 'spec/mock_accounts.csv' }
  let(:transactions_csv) {'spec/mock_transactions.csv'}
  let(:updated_accounts_csv) {'spec/updated_accounts_csv'}

  before do
    CSV.open(accounts_csv, 'w') do |csv|
      csv << ["00001", "1000.00"]
      csv << ["00002", "7500.00"]
    end

		CSV.open(transactions_csv, 'w') do |csv|
      csv << ["00001", "00002", "350.00"]
      csv << ["00001", "00002", "780.00"]
    end
  end

  after do
    [accounts_csv, transactions_csv, updated_accounts_csv].each do |file|
      File.delete(file) if File.exist?(file)
    end
  end

  it 'processes transactions and writes updated balances' do
    Bank.new(
      account_file: accounts_csv,
      transaction_file: transactions_csv,
      updated_account_file: updated_accounts_csv
    ).run

    updated = CSV.read(updated_accounts_csv, headers: false)
    expect(updated[0][1]).to eq('650.0')
    expect(updated[1][1]).to eq('7850.0')
  end

end
