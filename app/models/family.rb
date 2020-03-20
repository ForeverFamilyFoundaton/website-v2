class Family < ApplicationRecord
  has_many :family_memberships, inverse_of: :family
  has_many :users, through: :family_memberships
  accepts_nested_attributes_for :family_memberships, allow_destroy: true, reject_if: :all_blank
end
