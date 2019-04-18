class AppMailer < ApplicationMailer
    default from: 'pollendomeApp@example.com'
    layout 'mailer'

    def new_day_log
    mail(to: "eddiec76@gmail.com", subject: "Today's the day", body: "This is a test")
    end

end
