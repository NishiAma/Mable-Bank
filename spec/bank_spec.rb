require_relative '../lib/bank'
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
    File.delete(accounts_csv) if File.exist?(accounts_csv)
		File.delete(transactions_csv) if File.exist?(transactions_csv)
  end

  describe "When file exists for accounts" do
    it "loads accounts from CSV" do
        bank.load_accounts_from_file(accounts_csv)
        expect(bank.accounts['00001'].balance).to eq(1000.0)
        expect(bank.accounts['00002'].balance).to eq(7500.0)
    end
  end

	describe "When file does not exist for accounts" do
		it "raises error" do
			expect {
				bank.load_accounts_from_file("nonexisting_file.csv")
			}.to raise_error(ArgumentError, /File not found/)
		end
	end

	describe "When file exists for transactions" do
		it "loads transactions from transactions csv file" do
			transactions = bank.load_transactions_from_file(transactions_csv)
			expect(transactions[0].from_acc).to eq('00001');
			expect(transactions[1].from_acc).to eq('00001');
			expect(transactions[0].to_acc).to eq('00002');
			expect(transactions[1].to_acc).to eq('00002');
			expect(transactions[0].amount).to eq(350.0);
			expect(transactions[1].amount).to eq(780.0);
		end
	end

	describe "When file does not exist for transactions" do
		it "raises error" do
			expect {
				bank.load_transactions_from_file("nonexisting_file.csv")
			}.to raise_error(ArgumentError, /File not found/)
		end
	end

	describe "When files are available and processing" do
		it "processes transactions and updates balances correctly" do
			bank.load_accounts_from_file(accounts_csv)
			transactions = bank.load_transactions_from_file(transactions_csv)
			bank.process_transactions(transactions)

			expect(bank.accounts['00001'].balance).to eq(650.0)
			expect(bank.accounts['00002'].balance).to eq(7850.0)
		end
	end

	describe "When updating accounts" do
		before do
			File.delete(updated_accounts_csv) if File.exist?(updated_accounts_csv)
		end

		it "creates the csv file for updated accounts" do
			bank.export_updated_accounts(updated_accounts_csv)
			expect(File).to exist(updated_accounts_csv)
		end

		after do
			File.delete(updated_accounts_csv) if File.exist?(updated_accounts_csv)
		end
	end

end
