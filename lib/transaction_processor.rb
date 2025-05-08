require 'account'
require 'transaction'
require 'logger'

class TransactionProcessor
	def initialize(accounts, logger)
		@accounts = accounts
    @logger = logger
	end

	def process(transaction)
    from_acc = @accounts[transaction.from_acc]
    to_acc  = @accounts[transaction.to_acc]

    raise "Account not found" unless from_acc && to_acc

    begin
			from_acc.debit(transaction.amount)
			to_acc.credit(transaction.amount)
		rescue => e
			@logger.error("Failed transaction #{transaction.from_acc} -> #{transaction.to_acc} $#{transaction.amount}: #{e.message}")
		end
	end
end