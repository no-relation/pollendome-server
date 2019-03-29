require 'csv'

namespace :csv do
  
  desc "generates a migration file from column names from the CSV headers"
  task create_migration: :environment do 

    def headersFromCSV (filename)
      csvHeaderArray = CSV.open(filename, &:readline)
      return csvHeaderArray.map { |colA| colA.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    end
# "pollendromedataMOLD.csv" "pollendromedataPOLLEN.csv" "pollenDailyAverages.csv" "moldDailyAverages.csv"
    dataHeaders = headersFromCSV("pollendromedataMOLD.csv").concat(headersFromCSV("pollendromedataPOLLEN.csv"))
    forecastHeaders = headersFromCSV("pollenDailyAverages.csv").concat(headersFromCSV("moldDailyAverages.csv"))
    allHeaders = dataHeaders - forecastHeaders
    new_col_names = allHeaders - Day.column_names
    new_col_command = new_col_names.join(' ')
    if (new_col_command.length != 0)
      sh "rails generate migration AddSpeciesToDays #{new_col_command}"
    end
  end

end
