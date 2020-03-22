class FamilyMemberInvitation
  include ActiveModel::Model

  ROLE_OPTIONS = ['Parent', 'Child (18 and under)', 'Spouse / Significant other']

  attr_accessor :email, :role, :first_name, :last_name

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :email_is_unique

  private

  def email_is_unique
    if User.where(email: email).exists?
      errors.add(:email, 'has been taken.')
    end
  end
end
