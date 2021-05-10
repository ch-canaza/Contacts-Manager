class Failcontact < ApplicationRecord
  belongs_to :user
  #@generated_file = '/home/chris/reto_koombea/importador_de_contactos2/public/generated_data.csv'
  
  # def self.import_fail(file, user)
  #   if user
  #     $failed = false
  #     CSV.foreach(@generated_file, headers: true) do |row|
  #       puts row.headers
  #       puts '-------*-----'
  #       puts " inserting in failed -- #{row}"
  #       puts '-------*-----'

  #       @headers = row.headers
  #       user.failcontacts.create! row.to_hash
  #       $failed = true
  #       puts '-------*-----'
  #       puts "inserted into failed -- #{row}"
  #       puts '-------*-----'

  #     end
  #   end
  # end

end
