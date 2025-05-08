# Mable-Bank

## Introduction

This is a simple Ruby app created to illustrate a simple bank system.
The account details and transaction data are stored in CSV files with names `mable_account_balances.csv` and `mable_transactions.csv`.
The app reads the account balances and transactions, then process the transactions and updated account balances are exported in to `updated_account_balances.csv`.

## File Structure

### data

The folder `data` includes the input data files. The output data file is also created in this folder.

### lib

The folder `lib` includes the modal filed for account(`account.rb`) and transaction(`transaction.rb`). It includes `bank.rb` which reads the input files, store account balances, process transactions and export updated balances.

### log

The `log` folder is to save log files. In this application, if a transaction fails, it is logged with failing trasnaction's data in `failed_transactions.log` file inside this folder.

### spec

This is the folder for all specs. Specs are added for modals and bank.

### main file

`main.rb` is where this simple banking app is running. It includes the implemented steps needed to read from input files, process and export to output file.

## How to setup

- Step 1: Clone this reporitory and open a terminal within the root directory.
- Step 2: Run `bundle install`.
- Step 3: Run `ruby main.rb` to run main program.

- To run specs, run `rspec` in root directory.
