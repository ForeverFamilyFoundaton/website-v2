class FamilyMemberInvitation
  include ActiveModel::Model

  ROLE_OPTIONS = ['Parent', 'Child (18 and under)', 'Spouse / Significant other']

  attr_accessor :email, :role, :first_name, :last_name

  validates :email, presence: true
  validates :role, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
