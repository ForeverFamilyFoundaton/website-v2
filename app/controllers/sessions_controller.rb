class SessionsController < Devise::SessionsController
  before_action :get_cms_page, only: [:new, :create]

  private

  def get_cms_page
    @cms_page = CmsPage.find_by reference_string: :sign_in
  end
end
