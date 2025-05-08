require 'csv'
require 'logger'

require_relative 'account'
require_relative 'transaction'

class Bank
	def initialize
		@accounts = {}
		@logger = Logger.new('log/failed_transactions.log')
	end

	def load_accounts_from_file(file_path)
		is_file_existing(file_path)
		CSV.foreach(file_path, headers: false) do |row|
      @accounts[row[0]] = Account.new(id: row[0], balance: row[1])
    end
	end

	def load_transactions_from_file(file_path)
		is_file_existing(file_path)
		CSV.read(file_path, headers: false).map do |row|
      Transaction.new(from_acc: row[0], to_acc: row[1], amount: row[2])
    end
	end

	def process_transactions(transactions)
    transactions.each do |transaction|
      from_account = @accounts[transaction.from_acc]
      to_account = @accounts[transaction.to_acc]

      begin
        from_account.debit(transaction.amount)
        to_account.credit(transaction.amount)
      rescue => e
        @logger.error("Failed transaction #{transaction.from_acc} -> #{transaction.to_acc} $#{transaction.amount}: #{e.message}")
      end
    end
  end

	def export_updated_accounts(file_path)
    CSV.open(file_path, 'w') do |csv|
      @accounts.each do |id, account|
        csv << [id, format("%.2f", account.balance)]
      end
    end
  end

	def is_file_existing(file_path)
		unless File.exist?(file_path)
    	raise ArgumentError, "File not found: #{file_path}"
  	end
	end

	def accounts
    @accounts
  end
end