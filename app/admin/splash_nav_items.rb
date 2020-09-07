ActiveAdmin.register SplashNavItem do
  config.sort_order = 'row_order_asc'
  permit_params :title, :body, :image, :link

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
      f.input :image, as: :hidden, input_html: { value: f.object.cached_image_data }
      f.input :image, as: :file, hint: (
        image_tag(f.object.image(:thumbnail).url) if splash_nav_item.image.present?
      )
      f.input :link
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :body do |splash_nav_item|
        blog splash_nav_item.body
      end
      row :image do
        image_tag splash_nav_item.image(:thumbnail).url if splash_nav_item.image
      end
      row :link
    end
  end

  index row_class: -> record { 'splash-nav-item' } do
    column :title
    column :image_data do |splash_nav_item|
      image_tag(splash_nav_item.image(:thumbnail).url) if splash_nav_item.image.present?
    end
    column :row_order
    column :link
    actions
    column 'Move', class: 'drag-handle' do
      div do
        fa_icon 'bars', class: :fal
      end
    end
  end
end
