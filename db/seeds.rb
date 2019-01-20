# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

Feeling.destroy_all
User.destroy_all
Day.destroy_all

User.create(username: 'eddie', email: 'eddie@example.com', password: '0000')
User.create(username: 'susann', email: 'susann@example.com', password: '0000')
User.create(username: "Sneezy Dwarf", email: 'sneezy@fairy.land', password: '0000')

csvfileMOLD = CSV.read('pollendromedataMOLD.csv')
csvfilePOLLEN = CSV.read('pollendromedataPOLLEN.csv')
headersMOLD = csvfileMOLD[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
headersPOLLEN = csvfilePOLLEN[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
csvfileMOLD.shift
csvfilePOLLEN.shift

days = []

csvfileMOLD.each do |row|
    params = headersMOLD.zip(row.map {|item| item.downcase.strip}).to_h
    params["fulldate"] = Date.strptime(params["fulldate"], '%m/%d/%Y') if params["fulldate"] != "fulldate"
    
    day = Day.new(params)
    days << day
end

csvfilePOLLEN.each do |row|
    params = headersPOLLEN.zip(row.map {|item| item.downcase.strip}).to_h
    # params["fulldate"] = Date.strptime(params["fulldate"], '%m/%d/%Y') if params["fulldate"] != "fulldate"

    dayIndex = days.find_index {|day| day.fulldate == Date.parse(params["fulldate"])}
    if dayIndex
        days[dayIndex].attributes = params 
    else
        day = Day.new(params)
        days << day
    end
end

Day.import days

# selected_day_id = Day.find_by(fulldate: "").id
# Feeling.create(user_id: 3, rating: , day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-05-07").id
Feeling.create(user_id: 3, rating: 5, day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-05-08").id
Feeling.create(user_id: 3, rating: 5, day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-05-09").id
Feeling.create(user_id: 3, rating: 5, day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-05-10").id
Feeling.create(user_id: 3, rating: 5, day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-05-11").id
Feeling.create(user_id: 3, rating: 5, day_id: selected_day_id)

selected_day_id = Day.find_by(fulldate: "2018-09-17").id
Feeling.create(user_id: 3, rating: 0, day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-09-18").id
Feeling.create(user_id: 3, rating: 0, day_id: selected_day_id)
selected_day_id = Day.find_by(fulldate: "2018-09-19").id
Feeling.create(user_id: 3, rating: 0, day_id: selected_day_id)
