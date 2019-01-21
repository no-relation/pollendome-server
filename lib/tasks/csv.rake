require 'csv'

namespace :csv do
  desc "imports a CSV into a database, generating column names from the CSV headers"
  task create_migration: :environment do
    csvfileMOLD = CSV.read('pollendromedataMOLD.csv')
    csvfilePOLLEN = CSV.read('pollendromedataPOLLEN.csv')
    csvfilePollenDayForecast = CSV.read("pollenDailyyAverages.csv")
    
    headersMOLD = csvfileMOLD[0].map { |colA| colA.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    headersPOLLEN = csvfilePOLLEN[0].map { |colB| colB.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    headersPDayCast = csvfilePollenDayForecast[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    
    headers = headersMOLD.concat(headersPOLLEN, headersPDayCast)
    current_col_names =  Day.column_names
    new_col_names = headers - current_col_names
    new_col_command = new_col_names.join(' ')
    
    if (new_col_names.length != 0)
      sh "rails generate migration Add#{new_col_names[0].capitalize}ToDays #{new_col_command}"
    end
  end

end
