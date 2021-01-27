ActiveAdmin.register RadioShow do
  config.sort_order = 'date_desc'

  permit_params :title, :guest, :instructions, :date, :format, embeded_links_attributes: {}, attached_file_attributes: {}

  index do
    column :title do |q|
      link_to q.title, admin_radio_show_path(q)
    end
    column :guest
    column :date
    column :format
    column :attached_file do |q|
      link_to 'Download', q.attached_file.attachment.url if q.attached_file
    end
    actions
  end

  form html: { enctype: "multipart/form-data" } do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :guest
      f.input :instructions, input_html: { class: 'autogrow', rows: 5 }
      f.input :date, as: :datepicker,
      datepicker_options: {
        min_date: 21.years.ago.to_date,
        max_date: '+1y'
      }
      f.input :format, as: :select, collection: ['Signs of Life', 'Mediums & Messages', 'The Gathering', 'Medium Insights', 'Personal Experiences '].sort
    end

    f.inputs "Recording", for: [:attached_file, f.object.attached_file || AttachedFile.new] do |recording_form|
      recording_form.input :attachment, as: :file
    end

    f.inputs "Embedded Links" do
      f.has_many :embeded_links, allow_destroy: true do |embeded_link|
        embeded_link.input :title
        embeded_link.input :body
      end
    end

    f.actions
  end


  show do
    ul class: 'cms-collection' do
      render 'radio_shows/radio_show', { radio_show: radio_show }
    end
  end

end
