# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

User.destroy_all

User.create(username: 'eddie', email: 'eddie@example.com', password: '0000')
User.create(username: 'susann', email: 'susann@example.com', password: '0000')

Day.destroy_all

csvfile = CSV.read('pollendromedataMOLD.csv')
headers = csvfile[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }

days = []

CSV.foreach("pollendromedataMOLD.csv") do |row|
    params = headers.zip(row.map {|item| item.downcase.strip}).to_h
    params["fulldate"] = Date.strptime(params["fulldate"], '%m/%d/%Y') if params["fulldate"] != "fulldate"
    # if (params["month"] != "month") && (params["date"].to_i != 0) && (params["year"].to_i != 0)
    #     params["fulldate"] = Date.parse("#{params["year"]}#{params["month"]}#{params["date"]}").to_s
    # end
    
    day = Day.new(params)
    days << day
end

days.shift
Day.import days