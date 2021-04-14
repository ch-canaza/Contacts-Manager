class Failcontact < ApplicationRecord
  belongs_to :user

  def self.import_fail(file, user)
    if user
      $success = false
      CSV.foreach(file.path, headers: true) do |row|
        puts row.headers
        $headers = row.headers
        user.failcontacts.create! row.to_hash
      end
    end
  end

end
