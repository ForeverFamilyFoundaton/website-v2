ActiveAdmin.register Announcement do
  menu false
  permit_params :body, :link, :button, :start_date, :end_date

  index do
    column :body
    column :link, sortable: false do |announcement|
      link_to 'Link', admin_announcement_path(announcement)
    end
    column 'Button text', :button, sortable: false
    column :start_date
    column :end_date
    actions
  end

  show do
    attributes_table do
      row :body
      row :link
      row :button
      row :start_date
      row :end_date
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs "Details" do
      f.input :body, as: :string
      f.input :link, as: :string
      f.input :button, as: :string
      f.input :start_date, as: :datepicker,
      datepicker_options: {
        min_date: 3.months.ago.to_date,
        max_date: '+1y'
      }
      f.input :end_date, as: :datepicker,
      datepicker_options: {
        min_date: 3.months.ago.to_date,
        max_date: '+1y'
      }
    end
    f.actions
  end

  csv do
    column :body
    column :link
    column :button
    column :start_date
    column :end_date
  end
end
