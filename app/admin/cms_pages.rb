ActiveAdmin.register CmsPage do
  filter :title
  filter :reference_string
  filter :parent, input_html: { class: 'js-select' }

  permit_params :reference_string, :title, :sub_title, :body, :parent_id

  index do
    column :reference_string
    column 'Title' do |q|
      q.title
    end
    column 'URL' do |q|
      link_to page_by_id_url(q), page_by_id_url(q)
    end
    column :parent do |q|
      q.parent&.title
    end
    column :updated_at
    column "Actions" do |q|
      link_to 'Show', admin_cms_page_path(q)
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :reference_string
      f.input :parent, collection: CmsPage.order(reference_string: :asc).pluck(:reference_string, :id), input_html: { class: 'js-select' }
      f.input :title
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
    div cms_page.reference_string
    div do
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
      raw markdown.render(cms_page.body)
    end
  end
end
