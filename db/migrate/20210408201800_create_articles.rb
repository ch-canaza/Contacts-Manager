class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :full_name
      t.string :date_of_birth
      t.string :phone_number
      t.string :address
      t.string :credit_card
      t.string :franchise
      t.string :email

      t.timestamps
    end
  end
end
