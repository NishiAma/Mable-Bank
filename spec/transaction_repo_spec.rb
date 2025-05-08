require 'transaction_repo'
require 'csv'

RSpec.describe TransactionRepo do
	let(:transactions_csv) {'spec/mock_transactions.csv'}

	before do
    CSV.open(transactions_csv, 'w') do |csv|
      csv << ["00001", "00002", "350.00"]
      csv << ["00001", "00002", "780.00"]
		end
  end

	after do
    File.delete(transactions_csv) if File.exist?(transactions_csv)
	end

	describe ".load" do
		context "when file exists and format is CSV" do
			it "returns a list of transactions" do
				transactions = TransactionRepo.load(transactions_csv)
				expect(transactions[0].from_acc).to eq('00001');
				expect(transactions[1].from_acc).to eq('00001');
				expect(transactions[0].to_acc).to eq('00002');
				expect(transactions[1].to_acc).to eq('00002');
				expect(transactions[0].amount).to eq(350.0);
				expect(transactions[1].amount).to eq(780.0);
			end
		end

		context "when file exists but format is not csv" do
			let(:file_path) {'spec/transactions.text'}

			before do
				File.write(file_path, 'transactions as text file') 
			end

			after do
				File.delete(file_path) if File.exist?(file_path)
			end

			it "raises error" do
				expect {TransactionRepo.load(file_path)}.to raise_error(ArgumentError, /Invalid file format/)
			end
		end

		context "when file does not exist" do
			it "raises error" do
				expect {TransactionRepo.load('nonexistent.csv')}.to raise_error(ArgumentError, /File not found/)
			end
		end
	end
end