RSpec.describe CmsPage do
  subject(:cms_page) { cms_pages(:beer_is_great) }

  it { should validate_presence_of :reference_string }

  describe '#partial_name' do
    let(:expected_name) { cms_page.slug.underscore }

    it 'returns the underscored slug' do
      expect(cms_page.partial_name).to eq expected_name
    end
  end
end
