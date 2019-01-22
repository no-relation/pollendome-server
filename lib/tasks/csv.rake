require 'csv'

namespace :csv do
  
  desc "generates a migration file from column names from the CSV headers"
  task create_migration: :environment do 

    def headersFromCSV (filename)
      csvArray = CSV.read(filename)
      return csvArray[0].map { |colA| colA.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    end
# "pollendromedataMOLD.csv" "pollendromedataPOLLEN.csv" "pollenDailyAverages.csv" "moldDailyAverages.csv"
    headers = headersFromCSV("pollendromedataMOLD.csv").concat(headersFromCSV("pollendromedataPOLLEN.csv"))
    current_col_names =  Day.column_names
    new_col_names = headers - current_col_names
    new_col_command = new_col_names.join(' ')
    byebug
    if (new_col_names.length != 0)
      sh "rails generate migration AddSpeciesToDays #{new_col_command}"
    end
  end

end
