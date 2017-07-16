class FileUploadService
  
  def initialize(file_params)
    @file = file_params[:file]
  end

  def create
    binding.pry
    message = {status: 'success', message: 'Uploaded successfully.'}
    begin
      rows = CSV.read(@file.path)
    # convert headers
      headers = rows.shift.map { | header| header.gsub!(/( )/, '_').downcase! }
      # Generate contacts hash
      contacts = rows.map { |row| Hash[headers.zip(row)] }
      Contact.create(contacts)
    rescue Exception => e
      return { status: 'failed', message: 'Please uplaod file with valid data' }
    end
    message
  end
end