require 'logger'
require 'csv'
require_relative './lib/bank'

ACCOUNT_FILE     = 'data/mable_account_balances.csv'
TRANSACTION_FILE = 'data/mable_transactions.csv'
OUTPUT_FILE      = 'data/updated_account_balances.csv'

Bank.new(
  account_file: ACCOUNT_FILE,
  transaction_file: TRANSACTION_FILE,
  updated_account_file: OUTPUT_FILE
).run
