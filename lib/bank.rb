require 'csv'

require_relative 'account'

class Bank
	def initialize
		@accounts = {}
	end

	def load_accounts_from_file(file_path)
		is_file_existing(file_path)
		CSV.foreach(file_path, headers: false) do |row|
      @accounts[row[0]] = Account.new(id: row[0], balance: row[1])
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