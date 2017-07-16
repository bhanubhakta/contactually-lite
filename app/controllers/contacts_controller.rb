class ContactsController < ApplicationController
  def index
    
  end

  def upload
    result = FileUploadService.new(upload_params).create
    if result[:status] == 'failed'
      flash[:error] = result[:message]
      redirect_to root_path and return
    end
    flash[:success] = result[:message]
    redirect_to contacts_path
  end

  def new
    @contact = Contact.new
  end

  def destroy
    
  end
end