class CreateFileuploads < ActiveRecord::Migration[6.1]
  def change
    create_table :fileuploads do |t|
      t.text :file

      t.timestamps
    end
  end
end
