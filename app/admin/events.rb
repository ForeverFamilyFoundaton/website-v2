ActiveAdmin.register Event do
  menu false

  include ActionView::Helpers::TextHelper

  permit_params :title, :teaser, :description, :start_time, :end_time, :url, :pic_link

  config.sort_order = "start_time_desc"

  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)

  index do
    column 'Link' do |event|
      link_to event_path(event), event
    end
    column :title do |q|
      if q.url.present?
        link_to q.title, q.url, target: '_blank'
      else
        q.title
      end
    end
    column :teaser
    column :start_time
    column :end_time
    actions
  end


  form do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :url
      f.input :pic_link
      f.input :teaser, input_html: { class: [:code, :markdown] }
      f.input :description, input_html: { class: [:code, :markdown] }
      f.input :start_time
      f.input :end_time
      f.text_node "Your current time: " + Time.now.to_s + " " + Time.now.localtime.zone
    end
    f.actions
  end

  show do
    h1 do
      link_to event.title, event.url, target: '_blank'
    end
    h2 event_times(event)
    h3 'Teaser'
    div do
      raw markdown.render(event.teaser)
    end
    h3 'Description'
    div do
      raw markdown.render(event.description)
    end
  end

end
