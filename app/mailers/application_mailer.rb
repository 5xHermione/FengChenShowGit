class ApplicationMailer < ActionMailer::Base
  default from: ENV["SMTP_DOMAIN"]
  layout 'mailer'

  def go

    mail to: 'b10432020@gapps.ntust.edu.tw',
         subject: "Hello",
         content_type: "text/html"
  end
end
