class FamilyMembership < ApplicationRecord
  belongs_to :user
  belongs_to :family, inverse_of: :family_memberships
  validates :role, presence: true
end
