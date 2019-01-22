require 'csv'

namespace :csv do
  desc "imports a CSV into a database, generating column names from the CSV headers"
  task create_migration: :environment do
    def headersFromCSV (filename)
      csvArray = CSV.read(filename)
      return csvArray[0].map { |colA| colA.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    end
    
    # csvfileMOLD = CSV.read('pollendromedataMOLD.csv')
    # headersMOLD = csvfileMOLD[0].map { |colA| colA.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    # csvfilePOLLEN = CSV.read('pollendromedataPOLLEN.csv')
    # headersPOLLEN = csvfilePOLLEN[0].map { |colB| colB.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }

    # csvfilePollenDayForecast = CSV.read("pollenDailyyAverages.csv")
    # headersPDayCast = csvfilePollenDayForecast[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    

    headers = headersFromCSV("pollendromedataMOLD.csv").concat(headersFromCSV("pollendromedataPOLLEN.csv"), headersFromCSV("pollenDailyyAverages.csv"))
    byebug
    current_col_names =  Day.column_names
    new_col_names = headers - current_col_names
    new_col_command = new_col_names.join(' ')
    
    if (new_col_names.length != 0)
      sh "rails generate migration Add#{new_col_names[0].capitalize}ToDays #{new_col_command}"
    end
  end

end
