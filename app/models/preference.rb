class Preference < ApplicationRecord
  validates :name, presence: true

  has_many :user_preference_selections
  has_many :users, through: :user_preference_selection

  scope :profile, -> { where(preference_type: 'Profile') }
  scope :subscription, -> { where(preference_type: 'Subscription') }
  #scope :medium_preferences, -> { where(preference_type: 'Medium') }
  scope :adg, -> { where(preference_type: 'ADG') }
end
