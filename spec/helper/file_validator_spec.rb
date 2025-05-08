require_relative '../../lib/helper/file_validator'

RSpec.describe FileValidator do
	let(:file_path) { 'spec/helper/testfile.csv' }

	after do
		File.delete(file_path) if File.exist?(file_path)
	end

  describe '.validate' do
    context 'when file does not exist' do
      it 'raises an ArgumentError for missing file' do
        expect {
          FileValidator.validate('nonexistent.csv')
        }.to raise_error(ArgumentError, /File not found/)
      end
    end

    context 'when file exists but without extension' do
      it 'raises an ArgumentError for invalid file format' do
        file_path = 'spec/helper/testfile'
        File.write(file_path, 'test')
        expect {
          FileValidator.validate(file_path)
        }.to raise_error(ArgumentError, /Invalid file format/)
      end
    end

		context 'when file exists but with other extension' do
      it 'raises an ArgumentError for invalid file format' do
        file_path = 'spec/helper/testfile.txt'
        File.write(file_path, 'test')
        expect {
          FileValidator.validate(file_path)
        }.to raise_error(ArgumentError, /Invalid file format/)
      end
    end

    context 'when file exists and has a valid extension' do
      it 'does not raise an error' do
        file_path = 'spec/helper/testfile.csv'
        File.write(file_path, 'name,amount')
        expect {
          FileValidator.validate(file_path)
        }.not_to raise_error
      end
    end
  end
end