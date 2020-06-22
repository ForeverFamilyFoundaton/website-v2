class User < ApplicationRecord
  include Discard::Model

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  # # attr_accessible :category_ids, :categories
  # has_and_belongs_to_many :roles
  # has_many :user_categories
  # has_many :categories, through: :user_categories

  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
  has_one :business
  has_one :family_membership, inverse_of: :user, dependent: :destroy
  has_one :family, through: :family_membership
  has_many :subscriptions
  has_many :charges
  has_many :user_preference_selections
  has_many :preferences, through: :user_preference_selections

  phony_normalize :cell_phone, default_country_code: 'US'
  phony_normalize :home_phone, default_country_code: 'US'
  phony_normalize :work_phone, default_country_code: 'US'

  validates :cell_phone, phony_plausible: true
  validates :home_phone, phony_plausible: true
  validates :work_phone, phony_plausible: true

  attr_accessor :role

  def family_members
    family.members.where.not(id: id)
  end

  def family_owner?
    family_membership.role == 'Owner'
  end

  def has_preference?(preference)
    preferences.include?(preference)
  end

  def subscribed?
    subscription && subscription.active?
  end

  def subscription
    subscriptions.last
  end

  def subscribe(plan, options={})
    stripe_customer if !stripe_id?

    args = {
      customer: stripe_id,
      items: [{ plan: plan }],
      expand: ['latest_invoice.payment_intent'],
      off_session: true,
    }.merge(options)

    args[:trial_from_plan] = true if !args[:trial_period_days]

    sub = Stripe::Subscription.create(args)

    subscription = subscriptions.create(
      stripe_id: sub.id,
      stripe_plan: plan,
      status: sub.status,
      trial_ends_at: (sub.trial_end ? Time.at(sub.trial_end) : nil),
      ends_at: nil,
    )

    if sub.status == "incomplete" && ["requires_action", "requires_payment_method"].include?(sub.latest_invoice.payment_intent.status)
      raise PaymentIncomplete.new(sub.latest_invoice.payment_intent), "Subscription requires authentication"
    end

    subscription
  end

  def create_setup_intent
    stripe_customer if !stripe_id
    Stripe::SetupIntent.create(customer: stripe_id)
  end

  def update_card(payment_method_id)
    stripe_customer if !stripe_id?

    payment_method = Stripe::PaymentMethod.attach(payment_method_id, { customer: stripe_id })
    Stripe::Customer.update(stripe_id, invoice_settings: { default_payment_method: payment_method.id })

    update(
      card_brand: payment_method.card.brand.titleize,
      card_last4: payment_method.card.last4,
      card_exp_month: payment_method.card.exp_month,
      card_exp_year: payment_method.card.exp_year
    )
  end

  def stripe_customer
    if stripe_id
      Stripe::Customer.retreveve(stripe_id)
    else
      customer = Stripe::Customer.create(email: email, name: full_name)
      update stripe_id: customer.id
      customer
    end
  end
  # has_one :sitterform
  # has_one :mediumform
  # has_many :family_members
  # has_many :known_deads
  # has_many :relationships, through: :known_deads
  # accepts_nested_attributes_for :known_deads, reject_if: proc { |a| a[:name].blank? }, allow_destroy: true
  # has_many :adg_answers
  # has_many :notes
  # has_many :profile_preferences, -> {where("preferences.preference_type = 'Profile'")},
  #   through: :user_preference_selections,
  #   source: :preference
  # has_many :subscription_preferences, -> {where("preferences.preference_type = 'Subscription'")},
  #   through: :user_preference_selections,
  #   source: :preference
  # has_many :adg_preferences, -> { where("preferences.preference_type = 'ADG'") },
  #   through: :user_preference_selections,
  #   source: :preference

  # accepts_nested_attributes_for :user_categories
  # accepts_nested_attributes_for :family_members

  # # attr_accessible :email, :email_confirmation, :password, :password_confirmation
  # # attr_accessible :first_name, :last_name, :middle_name
  # # attr_accessible :cell_phone, :work_phone, :home_phone, :address_attributes
  # # attr_accessible :family_members_attributes, :profile_preference_ids, :subscription_preference_ids, :terms_of_use, :is_business, :state, :fax, :enrolled_from, :id, :membership_number, :problems, :do_not_mail, :enrolled_at, :snail_mail
  # # attr_accessible :sitter_registration, :medium_registration
  # # attr_accessible :known_deads_attributes
  # validates_presence_of     :email
  # validates_confirmation_of :email, :if => :email_changed?
  # validates_uniqueness_of   :email, case_sensitive: false, allow_blank: true, if: :email_changed?
  # validates_format_of       :email, with: email_regexp, allow_blank: true, if: :email_changed?
  # validates_uniqueness_of   :membership_number
  # validates_presence_of   :membership_number
  # validates_associated :address
  # validates_presence_of :address
  # validates_presence_of :first_name, :last_name
  validates :terms_of_use, acceptance: true
  validates :refund_policy, acceptance: true
  validates :email_policy, acceptance: true
  validates :volunteer_policy, acceptance: true
  attr_accessor :refund_policy, :email_policy, :volunteer_policy
  #TODO: remove if we begin using confirmable
  # before_validation :assign_membership_number
  # before_create :build_address
  # after_create :welcome_message

  # scope :registered_for_adg, -> { includes(:adg_answers).where.not(adg_answers: { id: nil }) }

  # comma do
  #   id
  #   membership_number
  #   first_name
  #   middle_name
  #   last_name
  #   email
  #   cell_phone
  #   home_phone
  #   work_phone
  #   fax
  #   is_business
  #   preferences do |preferences|
  #     preferences.map(&:name).to_sentence
  #   end
  #   categories do |categories|
  #     categories.map(&:name).to_sentence
  #   end
  #   address :address
  #   address :city
  #   address :state
  #   address :zip
  #   address :country
  #   enrolled_from
  #   enrolled_at
  #   snail_mail
  #   do_not_mail
  #   last_sign_in_at
  #   created_at
  #   updated_at
  #   problems
  # end

  # validates_presence_of     :password, :if => :password_required?
  # validates_confirmation_of :password, :if => :password_required?
  # validates_length_of       :password, :within => password_length, :allow_blank => true, :message => I18n.t('')
  #
  def sitter_reg?
    sitter_registration
  end

  def medium_reg?
    medium_registration
  end

  def biz?
    business.present?
  end

  def has_role?(role)
    roles.detect{|r| r.name == role}
  end

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  private

  def assign_membership_number
    if membership_number.blank?
      self.membership_number = User.maximum(:membership_number).to_i + 1
    end
  end

  def welcome_message
    if welcome_template = CmsPage.where(reference_string: 'Email::Welcome').first
      UserMailer.welcome_email(self, welcome_template).deliver
    end
  end
end
