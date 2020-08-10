class Sitterform < ApplicationRecord
  belongs_to :user
  belongs_to :belief_type
  has_many :known_deads, inverse_of: :sitterform, dependent: :destroy
  accepts_nested_attributes_for :known_deads, reject_if: proc { |a| a[:name].blank? }, allow_destroy: true;
  has_many :relationships, through: :known_deads

  validates :signature_checkbox, presence: { if: :signature? }
  validates :signature, presence: { if: :signature_checkbox? }
  validate :relationship_and_date

  private

  def relationship_and_date
    self.known_deads.each do |d|
      if !d[:name].blank?
        if d[:relationship_id] == 1
          self.errors.add(:relationship, 'needs to be selected for ' + d[:name])
        end
        if d[:year_of_death].empty?
          self.errors.add(:year_of_death, 'needs to be filled in for ' + d[:name])
        elsif (d[:year_of_death].to_i < 1900 || d[:year_of_death].to_i > Date.current.year)
          self.errors.add(:year_of_death, 'must be between 1900- ' + Date.current.year.to_s + " for "+ d[:name])
        end
      end
    end
  end
end
