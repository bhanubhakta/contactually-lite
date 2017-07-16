class ContactsController < ApplicationController
  def index
    # This is entry point from where
    # the contacts is displayed in view
    # from datatable
    respond_to do |format|
      format.html
      format.json { render json: ContactDatatable.new(view_context) }
    end
  end

  def upload
    # File upload service is used for file uploading logic.
    result = FileUploadService.new(upload_params).create
    if result[:status] == 'failed'
      flash[:error] = result[:message]
      redirect_to root_path and return
    end
    flash[:success] = result[:message]
    redirect_to contacts_path
  end

  def new
    # Get a new contact form.
    # This also triggers a landing page.
    @contact = Contact.new
  end

  def destroy
    # Delete particular record from the view
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end

  private

  def upload_params
    params.permit(:file)
  end
end