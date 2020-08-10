class AdgRegistrationsController < ApplicationController
  before_action :require_registration

  def new
    AdgQuestion.all.each do |adg_question|
      current_user.adg_answers.build adg_question_id: adg_question.id
    end
  end

  def edit; end

  def update
    current_user.adg_answers_attributes = adg_registration_params['adg_answers_attributes'].values
    if current_user.valid?
      current_user.save
      redirect_to current_user, notice: t('.success')
    else
      flash[:error] = current_user.errors.full_messages.join(' ')
      render 'edit'
    end
  end


  private

  def adg_registration_params
    params.require(:user).permit adg_answers_attributes: [:adg_question_id, :answer, :id]
  end

  def require_registration
    unless current_user
      redirect_to new_user_registration_path, notice: I18n.t('adg_registrations.redirect')
    end
  end
end

