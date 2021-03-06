ActiveAdmin.register_page "Dashboard" do

  menu priority: 2, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel 'Primary Links' do
          ul do
            li link_to 'Announcements', admin_announcements_path
            li link_to 'Cms Pages', admin_cms_pages_path
            li link_to 'Events', admin_events_path
            li link_to 'Radio Shows', admin_radio_shows_path
            li link_to 'Recommended Books', admin_recommended_books_path
            li link_to 'Users', admin_users_path
          end
        end
      end
      column do
        panel 'Secondary Links' do
          ul do
            li link_to 'Adg Questions', admin_adg_questions_path
            li link_to 'Attached Files', admin_attached_files_path
            li link_to 'Categories', admin_categories_path
            li link_to 'Cms Images', admin_cms_images_path
            li link_to 'External Links', admin_external_links_path
            li link_to 'Medium Registration', admin_mediumforms_path
            li link_to 'Mediumform Preferences', admin_mediumform_preferences_path
            li link_to 'Preferences', admin_preferences_path
            li link_to 'Recommended Book Categories', admin_recommended_book_categories_path
            li link_to 'Sitter Registration', admin_sitterforms_path
            li link_to 'Splash Nav Items', admin_splash_nav_items_path
          end
        end
      end
    end
  end # content
end
