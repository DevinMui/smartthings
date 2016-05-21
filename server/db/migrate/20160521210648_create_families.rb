class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.text :address

      t.timestamps null: false
    end
  end
end
