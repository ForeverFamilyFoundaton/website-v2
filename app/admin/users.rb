ActiveAdmin.register User do
  menu false

  permit_params(
    :id,
    :password,
    :password_confirmation,
    :do_not_mail,
    :snail_mail,
    :first_name,
    :middle_name,
    :last_name,
    :email,
    :cell_phone,
    :home_phone,
    :work_phone,
    :fax,
    :medium_registration,
    :sitter_registration,
    :is_business,
    :membership_number,
    :enrolled_from,
    :enrolled_at,
    :problems,
    category_ids: [],
    preference_ids: [],
    role_ids: [],
    address_attributes: [
      :id,
      :address,
      :city,
      :state,
      :zip,
      :country
    ]
  )

  scope :active, :kept, default: true
  scope :soft_deleted, :discarded
  scope :all
  scope 'Registered for ADG', :registered_for_adg

  action_item :soft_delete, only: :show, if: proc{ !user.discarded? } do
    link_to 'Soft-Delete', soft_delete_admin_user_path(user), method: :delete, data: { confirm: "Are you sure you want to soft-delete this user?" }
  end

  action_item :un_soft_delete, only: :show, if: proc{ user.discarded? } do
    link_to 'Un-Soft-Delete', un_soft_delete_admin_user_path(user), method: :put, data: { confirm: "Are you sure you want to UN-soft-delete this user?" }
  end

  action_item :confirm, only: :show, if: proc{ user.confirmed_at.nil? } do
    link_to 'Confirm', confirm_admin_user_path(user), method: :put, data: { confirm: "Manually confirm User?" }
  end

  member_action :soft_delete, method: :delete do
    resource.discard
    redirect_to admin_users_path, notice: "User #{resource.id} has been soft-deleted."
  end

  member_action :un_soft_delete, method: :put do
    resource.undiscard
    redirect_to admin_users_path, notice: "User #{resource.id} has been reinstated."
  end

  member_action :confirm, method: :put do
    resource.update_column :confirmed_at, Time.now
    redirect_to admin_user_path(resource), notice: "User #{resource.email} has been confirmed."
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:business)
    end
  end

  filter :id
  filter :membership_number
  filter :confirmed_at_not_null, as: :boolean, label: 'Confirmed?'
  filter :email
  filter :first_name
  filter :middle_name
  filter :last_name
  filter :roles
  filter :is_business
  filter :enrolled_from
  filter :snail_mail
  filter :do_not_mail
  filter :problems
  filter :categories, as: :check_boxes
  filter :address_state_contains
  filter :address_country_contains
  filter :preferences, as: :check_boxes

  index download_links: [:csv] do
    column :id
    column :membership_number
    column :first_name
    column :last_name
    column :email, sortable: :email
    column :roles
    column 'Confirmed?' do |user|
      user.confirmed_at? ? user.confirmed_at.to_s(:short) : false
    end

    actions
  end

  show do |user|
    attributes_table do
      row :confirmed_at do |user|
        user.confirmed_at.nil? ? 'N/A' : user.confirmed_at.to_s(:short)
      end
      row :deleted_at
      row :name do
        [user.first_name, user.middle_name, user.last_name].join(' ')
      end
      row :id
      row :membership_number
      row :email
      row :roles
      row :cell_phone
      row :home_phone
      row :work_phone
      row :categories do
        user.categories.map(&:name).to_sentence
      end
      row :fax
      row :medium_registration
      row :link_to_mediumform do
        if user.mediumform.present?
          link_to('Mediumform is Here', admin_mediumform_path(user.mediumform.id))
        else
          status_tag("No Mediumform Available")
        end
      end
      row :sitter_registration
      row :link_to_sitterform do
        if user.sitterform.present?
          link_to('Sitterform is Here', admin_sitterform_path(user.sitterform.id))
        else
          status_tag("No Sitterform Available")
        end
      end
      row :address do
        user.address
      end
      row :enrolled_from
      row :enrolled_at
      row :do_not_mail
      row :snail_mail
      row :last_sign_in_at
      row :created_at
      row :updated_at
      row :problems
    end

    table_for user.adg_answers do
      column "Question" do |question|
        question.question
      end

      column "Answer" do |question|
        question.answer
      end
    end

    table_for user.preferences.profile do
      column "Profile Preferences" do |question|
        question.name
      end
    end

    table_for user.preferences.subscription do
      column "Subscription Preferences" do |question|
        question.name
      end
    end

    table_for user.family_members do
      column :family_member, :name_and_relationship
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :membership_number
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :roles
      f.input :cell_phone
      f.input :home_phone
      f.input :work_phone
      f.input :fax
      f.input :medium_registration, as: :boolean
      f.input :sitter_registration, as: :boolean
      f.input :enrolled_from
      f.input :enrolled_at, start_year: 2004
      f.input :do_not_mail
      f.input :snail_mail
      f.input :problems
      f.input :categories, as: :check_boxes
      f.input :preferences, as: :check_boxes, collection: Preference.profile, label: 'Profile Preferences'
      f.input :preferences, as: :check_boxes, collection: Preference.subscription, label: 'Subscription Preferences'
      f.inputs "Address", for: [:address, f.object.address || Address.new] do |address|
        address.input :address
        address.input :city
        address.input :state
        address.input :zip
        address.input :country
      end
    end
    f.actions
  end

  csv do
    column :id
    column :membership_number
    column :first_name
    column :middle_name
    column :last_name
    column :email
    column :cell_phone
    column :home_phone
    column :work_phone
    column :fax
    column :is_business
    column('Preferences') do |user|
      user.try(:preferences).map(&:name).to_sentence
    end
    column('Categories') do |user|
      user.try(:categories).map(&:name).to_sentence
    end
    column("Address: Street") { |user| user.address.try(:address) }
    column("Address: City") { |user| user.address.try(:city) }
    column("Address: State") { |user| user.address.try(:state) }
    column("Address: Zip") { |user| user.address.try(:zip) }
    column("Address: Country") { |user| user.address.try(:country) }
    column :enrolled_from
    column :enrolled_at
    column :do_not_mail
    column :snail_mail
    column :last_sign_in_at
    column :created_at
    column :updated_at
    column :problems
  end
end
