class FamilyMember < ApplicationRecord
  belongs_to :family
  belongs_to :user, inverse_of: :family_member
  accepts_nested_attributes_for :user, reject_if: :all_blank

  def name_and_relationship
    [first_name, last_name].join(' ') + ': ' + relationship.to_s
  end
end

