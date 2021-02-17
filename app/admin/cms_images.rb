ActiveAdmin.register CmsImage do
  menu false

  permit_params :title, :image, :caption

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "CMS Image", :multipart => true do
      f.input :title
      f.input :image
      f.input :caption
    end
    f.actions
  end

  index do
    column 'Thumbnail' do |q|
      image_tag q.image.url(:thumb)
    end
    column 'URL' do |q|
      link_to q.image.url, q.image.url
    end
    column :title
    column :caption
    actions
  end

  show do
    h2 cms_image.title
    h4 cms_image.image.url
    h4 cms_image.caption
    div do
      image_tag cms_image.image.url
    end
  end
end
