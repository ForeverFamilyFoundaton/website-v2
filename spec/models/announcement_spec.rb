RSpec.describe Announcement do
  let(:announcement) { announcements(:free_beer) }
  let(:params) do
    {
      button: button,
      body: body,
      link: link,
      start_date: start_date,
      end_date: end_date
    }
  end
  let(:button) { Faker::Lorem.word }
  let(:body) { Faker::Lorem.sentence }
  let(:link) { Faker::Internet.url }
  let(:new_announcement) do
    Announcement.new params
  end

  it { is_expected.to validate_presence_of :button }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :link }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }

  context 'validate overlapping dates' do
    let(:start_date) { announcement.start_date }
    let(:end_date) { announcement.end_date }

    before do
      announcement
    end

    it 'is invalid with overlapping dates' do
      expect(new_announcement).not_to be_valid
    end
  end

  context 'with end_date < start_date' do
    let(:start_date) { announcement.start_date }
    let(:end_date) { announcement.start_date - 1.day }

    it 'is invalid' do
      expect(new_announcement).not_to be_valid
    end
  end
end
