require 'csv'

namespace :csv do
  desc "imports a CSV into a database, generating column names from the CSV headers"
  task create_migration: :environment do
    csvfile = CSV.read('pollendromedataMOLD.csv')
    headers = csvfile[0].map { |col| col.strip.downcase.gsub(' ', '_').gsub('/', '_').gsub(/[^\w_]/, '') }
    current_col_names =  Day.column_names
    new_col_names = headers - current_col_names
    new_col_command = new_col_names.join(' ')
    sh "rails generate migration Add#{new_col_names.length}SpeciesToDays #{new_col_command}"
  end

end
