def pause
  puts 'pausing...'
  STDIN.gets
end

def accept_invitation(email, password)
  open_email email
  current_email.click_link 'Accept invitation'
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_on I18n.t('devise.invitations.edit.submit_button')
end

def js_select(item_text, options)
  container = find(:xpath, "//parent::*[label[text()='#{options[:from]}']]")

  within "##{container[:id]}", visible: false do
    find('.ss-arrow').click
    input = find(".ss-search input").native
    input.send_keys(item_text)
    find('div.ss-list').click
  end
end
