RSpec.shared_context 'User Profile Data' do
  let(:first_name) { Faker::Name.first_name }
  let(:middle_name) { Faker::Name.middle_name }
  let(:last_name) { Faker::Name.last_name }
  let(:cell_phone) { Faker::PhoneNumber.cell_phone }
  let(:home_phone) { Faker::PhoneNumber.phone_number }
  let(:work_phone) { Faker::PhoneNumber.cell_phone }
  let(:home_email) { Faker::Internet.email }
  let(:work_email) { Faker::Internet.email }
  let(:street_address_1) { Faker::Address.street_address }
  let(:street_address_2) { Faker::Address.building_number }
  let(:city) { Faker::Address.city }
  let(:state) { Faker::Address.state }
  let(:zip) { Faker::Address.zip }
  let(:country) { Faker::Address.country }
  let(:password) { 'password' }
end
