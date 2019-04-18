namespace :mailer do
    task test: :environment do
        puts "Emailing..."
        AppMailer.new_day_log.deliver
    end
end