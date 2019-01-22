class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.date :fulldate
      t.integer :month
      t.integer :date
      t.integer :year
      t.integer :day 
      t.integer :week

      t.timestamps
    end
  end
end
