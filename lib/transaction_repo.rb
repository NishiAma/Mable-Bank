require_relative './helper/file_validator'
require_relative './transaction'

class TransactionRepo
	def self.load(file_path)
    FileValidator.validate(file_path)

    CSV.read(file_path, headers: false).map do |row|
      Transaction.new(from_acc: row[0], to_acc: row[1], amount: row[2].to_f)
    end
  end
end