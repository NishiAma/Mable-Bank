require 'logger'
require_relative './account_repo'
require_relative './transaction_repo'
require_relative './transaction_processor'

class Bank
	def initialize(account_file:, transaction_file:, updated_account_file:)
    @account_file = account_file
    @transaction_file = transaction_file
    @updated_account_file = updated_account_file
    @logger = Logger.new('log/failed_transactions.log')
  end

  def run
    accounts = AccountRepo.load(@account_file)
    transactions = TransactionRepo.load(@transaction_file)
    processor = TransactionProcessor.new(accounts, @logger)

    transactions.each { |transaction| processor.process(transaction) }

    AccountRepo.save(@updated_account_file, accounts)
  end
end