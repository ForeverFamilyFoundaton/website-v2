class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates_presence_of :address, :city, :state, :zip

  def to_s
    "#{address} #{city}, #{state} #{zip} #{country}"
  end
end
