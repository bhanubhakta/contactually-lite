require 'rails_helper'

describe ContactsController do
  context 'get new' do
    subject { get :new }
    before  { subject }

    it "returns http success" do
      expect(response.status).to be 200
    end

    it "renders the  template" do
      expect(response).to render_template :new
    end
  end

  context "POST upload" do
    it "redirects to the index page when file is uploaded" do
      allow_any_instance_of(FileUploadService).to receive(:create).and_return({status: 'success'})
      post :upload, file: "contacts.csv"
      expect(response).to redirect_to contacts_path
    end

    it "redirects to the home page when file is not uploaded" do
      allow_any_instance_of(FileUploadService).to receive(:create).and_return({status: 'failed', message: 'file upload failed'})
      post :upload, file: "contacts.csv"
      expect(response).to redirect_to root_path
    end
  end
end