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

csvfile = CSV.read('pollendromedata.csv')
headers = csvfile[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }

days = []

CSV.foreach("pollendromedata.csv") do |row|
    params = headers.zip(row.map {|item| item.downcase.strip}).to_h
    day = Day.new(params)
    days << day
end

Day.import days
Day.first.destroy