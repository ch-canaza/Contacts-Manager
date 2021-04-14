class CreateFailedContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :failed_contacts do |t|
      t.string :full_name
      t.string :address
      t.string :email
      t.string :date_of_birth
      t.string :credit_card
      t.string :errors
      t.string :text

      t.timestamps
    end
  end
end
