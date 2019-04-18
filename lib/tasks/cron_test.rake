namespace :cron_test do
    desc "This is how we learn how to use crontab"
    task is_this_thing_on: :environment do
        puts "Everything seems to be working"
    end
end
