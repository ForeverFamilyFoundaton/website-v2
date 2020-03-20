# README
Forever Family Foundation Website.

# memberships
User registers
User adds family members
User subscribes

User
  belongs_to :family
  has_many :family_members, through: :family

Family


FamilyMemeber
  belongs_to :family
  has_one :user

  role :child/:spouse
