class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default(
     from: "Forever Family Foundation <info@foreverfamilyfoundation.org>",
  )

  def welcome_email(user, welcome_email)
    @user = user
    @body = welcome_email.body
    subject = welcome_email.subject
    user.attributes.keys.each do |key|
      @body.gsub!("@#{key.to_s}", user[key].to_s)
      subject.gsub!("@#{key.to_s}", user[key].to_s)
    end
    mail(to: user.email, subject: subject)
  end

  def new_medium_registration_notification(user)
    @user = user
    @url = admin_mediumform_url(user.mediumform)

    subject = 'New Medium Registration'
    to = Rails.application.credentials.new_registration_notification_email
    mail(to: to, subject: subject)
  end

  def adg_email(user, welcome_email)
    @user = user
    @body = welcome_email.body
    subject = welcome_email.subject
    user.attributes.keys.each do |key|
      @body.gsub!("@#{key.to_s}", user[key].to_s)
      subject.gsub!("@#{key.to_s}", user[key].to_s)
    end
    mail(to: user.email, subject: subject)
  end
end
