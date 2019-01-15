class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.string :month
      t.integer :date
      t.integer :year

      t.timestamps
    end
  end
end
