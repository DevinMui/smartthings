class AddLocationToShowers < ActiveRecord::Migration
  def change
  	add_column :showers, :location, :string
  end
end
