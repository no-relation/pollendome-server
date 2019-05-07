class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.string :name
      t.string :species_type
      t.string :description

      t.timestamps
    end
  end
end
