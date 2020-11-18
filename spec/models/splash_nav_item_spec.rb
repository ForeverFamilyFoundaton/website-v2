RSpec.describe SplashNavItem do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :cms_page }
end
