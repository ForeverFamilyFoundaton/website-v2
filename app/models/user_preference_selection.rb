class UserPreferenceSelection < ApplicationRecord
  belongs_to :user
  belongs_to :preference

  validates :preference_id, uniqueness: { scope: :user_id }
end
