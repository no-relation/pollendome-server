class CreateFeelings < ActiveRecord::Migration[5.2]
  def change
    create_table :feelings do |t|
      t.integer :rating
      t.belongs_to :day, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
