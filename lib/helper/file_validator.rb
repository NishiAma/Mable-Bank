class FileValidator
	def self.validate(file_path)
		raise ArgumentError, "File not found: #{file_path}" unless File.exist?(file_path)
		raise ArgumentError, "Invalid file format: #{file_path}" unless File.extname(file_path).eql? '.csv'
	end
end