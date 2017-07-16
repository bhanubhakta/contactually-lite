require 'rails_helper'

describe Contact do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email_address }
  it { should validate_presence_of :phone_number }
  it { should validate_presence_of :company_name }

  context 'creating record' do
    subject { Contact.create(record) }

    context 'wrong email address' do
      let(:record) do
        {
          first_name: 'Bhanu',
          last_name: 'Sigdel',
          email_address: 'abc@def.com',
          phone_number: '1234567890',
          company_name: 'Contactually'
        }
      end

      it 'should create a record' do
        expect{subject}.to change{Contact.count}.by(1)
      end
    end

    context 'wrong email address' do
      let(:record) do 
        {
          first_name: 'Bhanu',
          last_name: 'Sigdel',
          email_address: 'abc',
          phone_number: '1234567890',
          company_name: 'Contactually'
        }
      end

      it 'not create the record' do
        expect{subject}.to change{Contact.count}.by(0)
      end
    end
  end
end