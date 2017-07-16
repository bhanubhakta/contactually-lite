class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email_address, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :company_name, presence: true
end