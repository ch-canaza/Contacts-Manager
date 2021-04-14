class AddUserIdColumnToTables < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :user_id, :integer
    add_column :failed_contacts, :user_id, :integer
    add_column :fileuploads, :user_id, :integer

  end
end
