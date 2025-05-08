require_relative 'lib/bank'

ACCOUNT_FILE       = 'data/mable_account_balances.csv'
TRANSACTION_FILE   = 'data/mable_transactions.csv'
OUTPUT_FILE        = 'data/updated_account_balances.csv'

bank = Bank.new
bank.load_accounts_from_file(ACCOUNT_FILE)
transactions = bank.load_transactions_from_file(TRANSACTION_FILE)
bank.process_transactions(transactions)
bank.export_updated_accounts(OUTPUT_FILE)
puts "Updated balances written to updated_account_balances.csv"
