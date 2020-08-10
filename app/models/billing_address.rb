class BillingAddress < ApplicationRecord
  belongs_to :business
  validates_presence_of :city, :address, :country, :state ,:zip
end

