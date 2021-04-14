class Fileupload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  def previewer
    if csv_file
      $csv_preview = csv_file.open(&:first).parse_csv
      $myfile = csv_file
    else
      $csv_preview = %w[first second third fourth fifth sixth seventh]
    end
  end
end
