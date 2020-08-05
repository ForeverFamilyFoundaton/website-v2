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
