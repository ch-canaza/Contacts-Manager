class ChangeNameArticlesToContacts < ActiveRecord::Migration[6.1]
  def change
    rename_table :articles, :contacts
  end
end
