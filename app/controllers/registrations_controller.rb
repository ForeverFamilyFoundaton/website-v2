class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :get_cms_page, only: [:new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :generate_captcha, only: [:new]

  def new
    super do |resource|
      resource.build_address unless resource.address
    end
  end

  # def create
  #   build_resource(sign_up_params)
  #   if NewGoogleRecaptcha.human?( params[:new_google_recaptcha_token], "registrations", NewGoogleRecaptcha.minimum_score, resource)
  #     resource.build_address unless resource.address
  #     resource.save
  #   else
  #     flash[:alert] = "Sorry, we think you're a robot. Please try again."
  #     redirect_to new_user_registration_path
  #     return
  #   end
  # end

  def create
    if params[:captcha_answer].to_i != session[:captcha_answer]
      flash[:alert] = "Captcha answer is incorrect"
      redirect_to new_user_registration_path
      return
    end
    build_resource(sign_up_params)

    if resource.save
      redirect_to new_user_session_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:alert] = resource.errors.full_messages.join(", ")
      render :new
    end
  end

  # def create
  #   build_resource(sign_up_params)

  #   NewGoogleRecaptcha.human?(
  #     params[:new_google_recaptcha_token],
  #     "user",
  #     NewGoogleRecaptcha.minimum_score,
  #     resource) && resource.build_address unless resource.address && resource.save

  #   # yield resource if block_given?
  #   if resource.persisted?
  #     redirect_to new_user_session_path
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # end

  def edit
    resource.build_address unless resource.address
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
    devise_parameter_sanitizer.permit(:sign_up, keys: user_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: user_attrs)
  end

  def user_attrs
    [
      :email, :password, :terms_of_use, :refund_policy, :email_policy, :volunteer_policy,
      :first_name, :middle_name, :last_name, :cell_phone, :work_phone, :home_phone,
      address_attributes: [
        :id, :address, :city, :state, :zip, :country
      ]
    ]
  end

  def get_cms_page
    @cms_page = CmsPage.find_by reference_string: :registration
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

  def generate_captcha
    num1 = rand(1..10)
    num2 = rand(1..10)
    @captcha_question = "What is #{num1} + #{num2}?"
    puts "Captcha question: #{@captcha_question}"
    session[:captcha_answer] = num1 + num2
    puts "Captcha answer: #{session[:captcha_answer]}"
  end
end
