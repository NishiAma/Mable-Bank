require 'transaction_processor'

RSpec.describe TransactionProcessor do
	let(:from_acc) { Account.new(id: '00001', balance: 1000.0) }
  let(:to_acc) { Account.new(id: '00002', balance: 500.0) }
  let(:accounts) { { '00001' => from_acc, '00002' => to_acc } }
  let(:logger) { Logger.new(nil) } 
  let(:processor) { TransactionProcessor.new(accounts, logger) }

	context "when both accounts are invalid" do
		let(:transaction) { Transaction.new(from_acc: '001', to_acc: '002', amount: 200)}

		it "raises error" do
			expect{ processor.process(transaction)}.to raise_error('Account not found')
		end
	end

	context "when to account is invalid" do
		let(:transaction) { Transaction.new(from_acc: '00001', to_acc: '002', amount: 200)}

		it "raises error" do
			expect{ processor.process(transaction)}.to raise_error('Account not found')
		end
	end

	context "when from account is invalid" do
		let(:transaction) { Transaction.new(from_acc: '001', to_acc: '00002', amount: 200)}

		it "raises error" do
			expect{ processor.process(transaction)}.to raise_error('Account not found')
		end
	end

	context "when both accounts are valid but amount is insufficient" do
		let(:transaction) { Transaction.new(from_acc: '00001', to_acc: '00002', amount: 1550.50)}

		it "logs error and does not process transaction" do
			expect(logger).to receive(:error).with(/Failed transaction/)
			processor.process(transaction)
			expect(from_acc.balance).to eq(1000.0)
			expect(to_acc.balance).to eq(500.0)
		end
	end

	context "when both accounts are valid and amount is sufficient" do
		let(:transaction) { Transaction.new(from_acc: '00001', to_acc: '00002', amount: 550.50)}

		it "transaction is done successfully and balances are updated" do
			processor.process(transaction)
			expect(from_acc.balance).to eq(449.50)
			expect(to_acc.balance).to eq(1050.50)
		end
	end
end