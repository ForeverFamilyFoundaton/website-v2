ActiveAdmin.register SplashNavItem do
  menu false

  filter :cms_page
  filter :title
  filter :body
  filter :created_at
  filter :updated_at

  config.sort_order = 'row_order_asc'
  permit_params :title, :body, :image, :cms_page_id

  controller do
    def scoped_collection
      resource_class.rank(:row_order).all
    end
  end

  before_save do |splash_nav_item|
    if splash_nav_item.valid? && splash_nav_item.image_changed?
      splash_nav_item.image_derivatives!
    end
  end

  member_action :reorder, method: :put do
    resource.update row_order_position: params[:new_position]
    render json: { notice: "Position updated." }, status: :ok
  end

  form do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :body
      f.input :cms_page, input_html: { class: 'js-select' }
      f.input :image, as: :file, hint: f.object.image.present? &&
        image_tag(f.object.image(:thumbnail).url)
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :body do |splash_nav_item|
        blog splash_nav_item.body
      end
      row :cms_page
      row :image do
        image_tag splash_nav_item.image(:thumbnail).url if splash_nav_item.image
      end
    end
  end

  index row_class: -> record { 'splash-nav-item' } do
    column :title
    column :cms_page
    column :image_data do |splash_nav_item|
      image_tag(splash_nav_item.image(:thumbnail).url) if splash_nav_item.image.present?
    end
    actions
    column 'Move', class: 'drag-handle' do
      div do
        fa_icon 'bars', class: :fal
      end
    end
  end
end
