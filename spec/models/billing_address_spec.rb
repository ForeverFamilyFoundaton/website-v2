RSpec.describe BillingAddress do
  it { should belong_to :business }
  it { should validate_presence_of :city }
  it { should validate_presence_of :address }
  it { should validate_presence_of :country }
  it { should validate_presence_of :state }
  it { should validate_presence_of :zip }
end
