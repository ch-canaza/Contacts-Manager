class ChangeErrorsClumnTypeToArray < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:failed_contacts, :errors, from: :string, to: nil)
    change_column :failed_contacts, :errors, :string, array: true, using: "(string_to_array(errors, ','))"
    change_column_default(:failed_contacts, :errors, from: nil, to: [])
  end
end
