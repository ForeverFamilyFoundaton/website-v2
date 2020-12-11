class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :get_cms_page, only: [:new, :create]

  def create
    super do |resource|
      Family.create! family_memberships_attributes: [{ user: resource, role: 'Owner' }]
    end
  end

  def edit
    resource.build_address if !resource.address
    super
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_update_path_for(resource)
    user_path current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [
      :terms_of_use, :volunteer_policy, :refund_policy, :email_policy
    ]
    devise_parameter_sanitizer.permit(
      :account_update, keys: [
        :first_name,
        :middle_name,
        :last_name,
        :cell_phone,
        :work_phone,
        :home_phone,
        address_attributes: [
          :id,
          :address,
          :city,
          :state,
          :zip,
          :country
        ]
      ]
    )
  end

  def get_cms_page
    @cms_page = CmsPage.find_by reference_string: :registrations
  end

  def update_resource(object, attributes)
    update_method = if attributes[:password].present?
      :update_attributes
    else
      attributes.delete :current_password
      :update_without_password
    end
    object.send(update_method, attributes)
  end
end

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(
    :sign_up, keys: [
      :name, :phone, memberships_attributes: [
        :role, account_attributes: [:name, :terms_accepted]
      ]
    ]
  )
end
