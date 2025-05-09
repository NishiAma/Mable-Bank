# Mable-Bank

## Introduction

This is a simple Ruby app created to illustrate a simple bank system.
The account details and transaction data are stored in CSV files with names `mable_account_balances.csv` and `mable_transactions.csv`.
The app reads the account balances and transactions, then process the transactions and updated account balances are exported in to `updated_account_balances.csv`.

The file structure of the appliction code can be found in [docs/file_structure](docs/file_structure.md)

Details about the architecture of this application can be found in [docs/architecture](docs/architecture.md)

## How to setup

- Step 1: Clone this reporitory and open a terminal within the root directory.
- Step 2: Run `bundle install`.
- Step 3: Run `ruby main.rb` to run main program.

- To run specs, run `rspec` in root directory.
