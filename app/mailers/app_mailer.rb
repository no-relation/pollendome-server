class AppMailer < ApplicationMailer
    default from: 'pollendomeApp@example.com'
    layout 'mailer'

    def new_day_log(day)
        mail(
            to: "eddiec76@gmail.com", 
            subject: "POLLENDOME created day #{day.id} - #{day.fulldate}", 
            body: 
        )
    end

end
