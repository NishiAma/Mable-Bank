require_relative '../lib/bank'
require 'csv'

RSpec.describe Bank do
  let(:bank) { Bank.new }
  let(:accounts_csv) { 'spec/mock_accounts.csv' }

  before do
    CSV.open(accounts_csv, 'w') do |csv|
      csv << ["Account", "Balance"]
      csv << ["00001", "1000.00"]
      csv << ["00002", "7500.00"]
    end
  end

  after do
    File.delete(accounts_csv) if File.exist?(accounts_csv)
  end

  describe "When file exists" do
    it "loads accounts from CSV" do
        bank.load_accounts_from_file(accounts_csv)
        expect(bank.accounts['00001'].balance).to eq(1000.0)
        expect(bank.accounts['00002'].balance).to eq(7500.0)
    end
  end

	describe "When file does not exist" do
		it "raises error" do
			expect {
				bank.load_accounts_from_file("nonexistent_file.csv")
			}.to raise_error(ArgumentError, /File not found/)
		end
	end
end
