class AddSpeciesToDays < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :black_walnut, :string
    add_column :days, :walnutjuglans, :string
  end
end
