RSpec.feature 'As a user registering for a ADG Discussion group' do
  let(:user) { users(:homer) }
  let(:yes_or_no_question) { adg_questions(:yes_or_no_question) }
  let(:text_question) { adg_questions(:text_question) }
  let(:text_answer) { Faker::Lorem.paragraph }
  let(:yes_or_no_answer) { ['Yes', 'No'].sample }
  let(:text_answer_edit) { Faker::Lorem.paragraph }

  context 'who is registered' do
    before do
      login_as user
      visit user_path(user)
    end

    scenario 'I can fill out the ADG Registration' do
      within '.adg-registration' do
        click_on 'Begin Registration'
      end
      fill_in text_question.question, with: text_answer
      choose yes_or_no_answer
      click_on 'Save Registration'
      expect(page).to have_content I18n.t('adg_registrations.create.success')
      within '.adg-registration' do
        click_on 'Edit Registration'
      end
      expect(page).to have_field text_question.question, with: text_answer
      fill_in text_question.question, with: text_answer_edit
      click_on 'Save Registration'
      expect(page).to have_content I18n.t('adg_registrations.update.success')
      within '.adg-registration' do
        click_on 'Edit Registration'
      end
      expect(page).to have_field text_question.question, with: text_answer_edit
    end
  end

  context 'who is not registered' do
    it 'I am redirected to the main registration with a message' do
      visit new_adg_registration_path
      expect(page).to have_content I18n.t('adg_registrations.redirect')
    end
  end
end
