require 'rails_helper'

RSpec.describe ExtractRecommendedBookLinks do
  subject(:book) { recommended_books(:a_million_little_fibers) }
  let(:amazon_link) do
    "http://www.amazon.com/gp/product/0446349518/ref=as_li_tf_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0446349518&linkCode=as2&tag=wwwforeverfam-20"
  end
  let(:amazon_anchor) do <<-LINK
    <a href="#{amazon_link}">Esp, Hauntings and Poltergeists: A Parapsychologist's Handbook</a><img src="//ir-na.amazon-adsystem.com/e/ir?t=wwwforeverfam-20&l=as2&o=1&a=0446349518" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
    LINK
  end
  let(:uk_amazon_link) do
    "https://www.amazon.co.uk/gp/product/1471137139/ref=as_li_tl?ie=UTF8&camp=1634&creative=6738&creativeASIN=1471137139&linkCode=as2&tag=wwwforeverfam-21"
  end
  let(:uk_amazon_anchor) do <<-LINK
    <a rel="nofollow" href="#{uk_amazon_link}">Opening Heaven's Door: What the Dying Tell Us About Where They're Going</a><img src="//ir-uk.amazon-adsystem.com/e/ir?t=wwwforeverfam-21&l=as2&o=2&a=1471137139" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
    LINK
  end
  let(:cad_amazon_link) do
    "https://www.amazon.ca/gp/product/1908733551/ref=as_li_tf_tl?ie=UTF8&camp=15121&creative=330641&creativeASIN=1908733551&linkCode=as2&tag=wwwforeverf03-20"
  end
  let(:cad_amazon_anchor) do <<-LINK
    <a  href="#{cad_amazon_link}">Conversations with Ghosts</a><img src="//ir-ca.amazon-adsystem.com/e/ir?t=wwwforeverf03-20&l=as2&o=15&a=1908733551" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
    LINK
  end
  before do
    book.update_columns(
      amazon_link: amazon_anchor,
      uk_amazon_link: uk_amazon_anchor,
      cad_amazon_link: cad_amazon_anchor,
    )
    ExtractRecommendedBookLinks.new.up
  end

  it 'sets amazon_link' do
    expect(book.reload.amazon_link).to eq amazon_link
  end

  it 'sets amazon_link' do
    expect(book.reload.uk_amazon_link).to eq uk_amazon_link
  end

  it 'sets amazon_link' do
    expect(book.reload.cad_amazon_link).to eq cad_amazon_link
  end
end
