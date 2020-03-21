class Family < ApplicationRecord
  has_many :family_memberships, inverse_of: :family, dependent: :destroy
  has_many :users, through: :family_memberships
  accepts_nested_attributes_for :family_memberships, allow_destroy: true, reject_if: :all_blank
  alias_attribute :members, :users
end
