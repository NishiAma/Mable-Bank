require_relative '../lib/account_repo'
require 'csv'

RSpec.describe AccountRepo do
	let(:accounts_csv) { 'spec/mock_accounts.csv' }
  let(:updated_accounts_csv) {'spec/updated_accounts_csv'}

	before do
    CSV.open(accounts_csv, 'w') do |csv|
      csv << ["00001", "1000.00"]
      csv << ["00002", "7500.00"]
    end
  end

	after do
    File.delete(accounts_csv) if File.exist?(accounts_csv)
	end

	describe ".load" do
		context "when file exists and format is CSV" do
			it "returns a list of accounts" do
				accounts = AccountRepo.load(accounts_csv)
				expect(accounts['00001'].balance).to eq(1000.0)
				expect(accounts['00002'].balance).to eq(7500.0)
			end
		end

		context "when file exists and format is not CSV" do
			let(:file_path) {'spec/accounts.text'}

			before do
				File.write(file_path, 'accounts as text file') 
			end

			after do
				File.delete(file_path) if File.exist?(file_path)
			end

			it "raises error" do
				expect {AccountRepo.load(file_path)}.to raise_error(ArgumentError, /Invalid file format/)
			end
		end

		context "when file does not exist" do
			it "raises error" do
				expect {AccountRepo.load('nonexistent.csv')}.to raise_error(ArgumentError, /File not found/)
			end
		end
	end

	describe ".save" do
		context "when saving accounts to csv file" do
			before do
				File.delete(updated_accounts_csv) if File.exist?(updated_accounts_csv)
			end

			after do
				File.delete(updated_accounts_csv) if File.exist?(updated_accounts_csv)
			end

			it "creates the csv file for updated accounts" do
				accounts = {}
				accounts['00001'] = Account.new(id: '00001', balance: 500)
				accounts['00002'] = Account.new(id: '00002', balance: 750)
				AccountRepo.save(updated_accounts_csv, accounts)
				expect(File).to exist(updated_accounts_csv)
			end
		end
	end
end