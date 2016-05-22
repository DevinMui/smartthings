class CreateMotions < ActiveRecord::Migration
  def change
    create_table :motions do |t|
      t.integer :user_id
      t.boolean :motion

      t.timestamps null: false
    end
  end
end
