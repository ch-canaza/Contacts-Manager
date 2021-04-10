class Contact < ApplicationRecord
  VALID_PHONE_NUMBER = /\A[0-9]+\Z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i


  validates :full_name, 
            presence: true,
            length: { minimum: 3, maximum: 25 }
  validates :date_of_birth, 
            presence: true,
            length: { minimum: 3, maximum: 25 }
  validates :phone_number, 
            presence: true,
            uniqueness: true,
            length: { is: 11 },
            format: { with: VALID_PHONE_NUMBER }
  validates :address, 
            presence: true,
            length: { maximum: 25 }
  validates :credit_card, 
            presence: true,
            length: { maximum: 15 }
  validates :franchise, 
            presence: true,
            length: { maximum: 25 }
  validates :email, 
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { minimum: 3, maximum: 35 },
            format: { with: VALID_EMAIL_REGEX }

     
  has_one_attached :csv_file

  # def previewer
  #   @data1 = self.csv_file.open(&:second).parse_csv
  #   puts @data1
  #   $data = @data1
  # end
end
