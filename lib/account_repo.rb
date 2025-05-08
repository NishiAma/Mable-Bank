require_relative './helper/file_validator'
require_relative './account'

class AccountRepo
	def self.load(file_path)
    FileValidator.validate(file_path)

    accounts = {}
    CSV.foreach(file_path, headers: false) do |row|
      accounts[row[0]] = Account.new(id: row[0], balance: row[1])
    end
    accounts
  end

  def self.save(file_path, accounts)
    CSV.open(file_path, 'w') do |csv|
      accounts.each_value do |account|
        csv << [account.id, account.balance]
      end
    end
  end
end