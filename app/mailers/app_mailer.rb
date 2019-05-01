class AppMailer < ApplicationMailer
    default from: 'pollendomeApp@example.com'
    layout 'mailer'

    def new_day_log(day)
        dayParamsList = day.attributes.keys.map do |key|
            "#{key}: #{day[key]}"
        end
        dayParams = dayParamsList.join("\n")
        mail(
            to: "eddiec76@gmail.com", 
            subject: "POLLENDOME created day #{day[:id]} - #{day[:fulldate]}", 
            body: dayParams
        )
    end

end
