class Fileupload < ApplicationRecord
  has_one_attached :csv_file

  def previewer
    # self.csv_file.open do |file|
    #   CSV.foreach(file) do |row|
    #     puts row.data
    #   end
    # end
    $csv_preview = csv_file.open(&:first).parse_csv
    puts '--- previewer---'
    puts $csv_preview
    puts '--- pre ---'
    #$data = @data1
  end
end
