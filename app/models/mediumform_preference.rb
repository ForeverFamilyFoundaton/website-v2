class MediumformPreference < ApplicationRecord
  validates_presence_of :name

  has_many :mediumform_preference_selections
  has_many :mediumforms, through: :mediumform_preference_selections

  scope :selfclassify_preferences, -> { where(preference_type: 'SelfClassify') }
  scope :practice_preferences, -> { where(preference_type: 'Practice') }
end
