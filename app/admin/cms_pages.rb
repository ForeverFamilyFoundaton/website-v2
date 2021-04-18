ActiveAdmin.register CmsPage do
  menu false
  filter :title
  filter :reference_string
  filter :parent, input_html: { class: 'js-select' }
  filter :nav_item

  permit_params :reference_string, :title, :sub_title, :body, :parent_id, :nav_item

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    column :title
    column 'URL' do |cms_page|
      link_to page_path(cms_page), page_path(cms_page)
    end
    column :parent do |cms_page|
      cms_page.parent&.title
    end
    column :nav_item
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :reference_string, input_html: { disabled: !object.new_record? }
      f.input :parent, collection: CmsPage.order(reference_string: :asc).pluck(:reference_string, :id), input_html: { class: 'js-select' }, include_blank: true
      f.input :title
      f.input :nav_item
      f.input :sub_title
      f.input :body, label: false, input_html: { class: [:code, :markdown] }
      div do
        a href: 'https://www.markdownguide.org/basic-syntax/', target: :_blank do
          'Markdown Syntax Guide'
        end
      end
    end
    f.actions
  end

  show do
    div cms_page.parent.reference_string if cms_page.parent.present?
    h1 cms_page.title
    h2 cms_page.sub_title
    h2 cms_page.nav_item
    div cms_page.reference_string
    div do
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
      raw markdown.render(cms_page.body)
    end
  end
end
