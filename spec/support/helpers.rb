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
  # field_id = find_field(options[:from], visible: false)[:id]
  # byebug
  within "##{options[:from]}", visible: false do
    # find('a.chzn-single').click
    input = find(".ss-search input", visible: false).native

    input.send_keys(item_text)
    # find('ul.chzn-results').click
    input.send_key(:arrow_down, :return)
  end
end
