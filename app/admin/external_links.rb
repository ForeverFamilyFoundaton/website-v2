ActiveAdmin.register ExternalLink do
  menu false

  config.filters = false

  permit_params :text, :url

  index do
    column :text
    column :url do |link|
      raw link.url
    end
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :text
      f.input :url
    end
    f.actions
  end

  show do
    h1 do
      link_to external_link.text, external_link.url, target: '_blank'
    end
  end
end
