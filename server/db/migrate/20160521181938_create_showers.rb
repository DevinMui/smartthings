class CreateShowers < ActiveRecord::Migration
  def change
    create_table :showers do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :time_start
      t.datetime :time_stop
      t.float :time_total

      t.timestamps null: false
    end
  end
end
