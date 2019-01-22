class AddDayToDays < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :day, :integer
    add_column :days, :cottonwood, :string
    add_column :days, :mesquite, :string
    add_column :days, :sweetgum, :string
    add_column :days, :baldcypress, :string
    add_column :days, :otherweed, :string
    add_column :days, :othertree, :string
    add_column :days, :plantain, :string
  end
end
