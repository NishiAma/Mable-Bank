# File Structure

## data

The folder `data` includes the input data files. The output data file is also created in this folder.

## lib

The folder `lib` includes all the coding for this application.

- `account.rb`: This is the model for accounts.
- `transaction.rb` : This is the model for transactions.
- `account_repo.rb` : This holds the class responsible for loading and saving accounts from and to CSV files.
- `transaction_repo.rb` : This holds the class responsible for loading transactions from CSV file.
- `transaction_processor.rb`: This is the class which processes single transaction.
- `bank.rb` : This is the main orchestration class of this application. This combines all the pieces and creates the big picture.

## lib/helper

This is the folder which holds helper code to avoid redundancy. This has the `file_validator.rb` which has code for validating for its existance and format. It is used when loading a file.

## log

The `log` folder is to save log files. In this application, if a transaction fails, it is logged with failing trasnaction's data in `failed_transactions.log` file inside this folder.

## spec

This is the folder for all specs. Specs are added for models and bank.

## main file

`main.rb` is where this simple banking app is running.
