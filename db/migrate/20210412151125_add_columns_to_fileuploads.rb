class AddColumnsToFileuploads < ActiveRecord::Migration[6.1]
  def change
    add_column :fileuploads, :headers, :string, array: true
    add_column :fileuploads, :status, :string
  end
end
