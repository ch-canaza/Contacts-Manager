class CreateFailcontacts < ActiveRecord::Migration[6.1]
  def change
    create_table :failcontacts do |t|
      t.string :full_name
      t.string :address
      t.string :date_of_birth
      t.string :credit_card
      t.string :email
      t.string :phone_number
      t.string :franchise
      t.integer :user_id
      t.text :error_data

      t.timestamps
    end
  end
end
