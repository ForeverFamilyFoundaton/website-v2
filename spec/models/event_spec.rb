RSpec.describe Event do
  before(:all) do
    @events = FactoryBot.create_list(:event, 4)
  end

  after(:all) do
    @events.map(&:destroy)
  end

  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :title }

  describe "Upcoming events" do
    let(:upcoming) { Event.upcoming.map(&:start_time) }
    let(:first_time) { upcoming.first.to_i }
    let(:second_time) { upcoming[1].to_i }

    it "should have ascending order" do
      expect(first_time).to be < second_time
    end
  end
end
