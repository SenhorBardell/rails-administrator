class ApplicationMailer < ActionMailer::Base
  default from: 'senhorbardell@gmail.com'
  layout 'mailer'

  def user_email(user, email)
    if !email.present?
      nil
    else
      pdf = ActionController::Base.render pdf: 'temp', template: 'templates/user.pdf.erb', locals: {user: user}
      attachments["#{user.first_name} #{user.last_name}.pdf"] = pdf
      mail to: email, subject: "User #{user.first_name} #{user.last_name} details"
    end
  end
end
