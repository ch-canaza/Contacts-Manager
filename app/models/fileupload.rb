class Fileupload < ApplicationRecord
  belongs_to :user
  has_one_attached :csv_file

  after_create_commit { broadcast_prepend_to 'heading' }
  after_update_commit { broadcast_replace_to 'heading' }
  after_destroy_commit { broadcast_remove_to 'heading' }

  def self.header_previewer(csv_file)
    if csv_file
      CSV.foreach(csv_file, headers: true) do |row|
        @csv_preview = row.headers
        return @csv_preview
      end
    else
      return @csv_preview = %w[first_field second_field third_field fourth_field fifth_field sixth_field seventh_field]
    end
  end
  def self.content_previewer(csv_file)
  
  end
end
