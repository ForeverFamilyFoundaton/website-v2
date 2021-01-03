class ExtractRecommendedBookLinks < ActiveRecord::Migration[6.0]
  def up
    RecommendedBook.all.each do |book|
      [:amazon_link, :uk_amazon_link, :cad_amazon_link].each do |attr|
        anchor_tag = book.public_send attr
        if anchor_tag.present?
          match = /href\s*=\s*"([^"]*)"/.match(anchor_tag)
          book.public_send("#{attr}=",  match[1]) if match
        end
      end
      book.save!
    rescue => e
      puts book.id
    end
  end

  def down
    # raise ActiveRecord::IrreversibleMigration
  end
end
