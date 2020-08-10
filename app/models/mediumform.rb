class Mediumform < ApplicationRecord
  belongs_to :user
  has_many :mediumform_preference_selections
  has_many :mediumform_preferences, through: :mediumform_preference_selections
  has_many :selfclassify_preferences, -> { where("preference_type = 'SelfClassify'") }, through: :mediumform_preference_selections, source: :mediumform_preference
  has_many :practice_preferences, -> {where("preference_type = 'Practice'")},
    through: :mediumform_preference_selections,
    source: :mediumform_preference

  validates :signature_checkbox, presence: { if: :signature? }
  validates :signature, presence: { if: :signature_checkbox? }
end
