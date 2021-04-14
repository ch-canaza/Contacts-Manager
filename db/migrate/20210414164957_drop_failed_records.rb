class DropFailedRecords < ActiveRecord::Migration[6.1]
  def change
    drop_table :failed_contacts
  end
end
