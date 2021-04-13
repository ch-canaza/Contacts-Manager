class Contact < ApplicationRecord
  VALID_PHONE_NUMBER = /\A[0-9]+\Z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[a-zA-Z -]+\z/
  VALID_DATE_OF_BIRTH_REGEX_1 = /\A\d{4}-\d{2}-\d{2}\z/
  VALID_DATE_OF_BIRTH_REGEX_2 = /\A\d{4}\d{2}\d{2}\z/
  VALID_PHONE_NUMBER_REGEX_1 = /\A\(\+\d{2}\) \d{3} \d{3} \d{2} \d{2}\z/
  #VALID_PHONE_NUMBER_REGEX_2 = /\A\(\+\d{2}\) \d{3}-\d{3}-\d{2}-\d{2}\z/

  validates :full_name, 
            presence: true,
            format: {with: VALID_NAME_REGEX },
            length: { maximum: 75 }
  validates :date_of_birth, 
            presence: true,
            format: { with: VALID_DATE_OF_BIRTH_REGEX_1 }
  validates :phone_number, 
            presence: true,
            format: { with: VALID_PHONE_NUMBER_REGEX_1 }
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
            #uniqueness: { case_sensitive: false},
            length: { minimum: 3, maximum: 35 },
            format: { with: VALID_EMAIL_REGEX }

     
  has_one_attached :csv_file

  #validate :correct_phone_format
  #validate :correct_date_of_birth_format


  def self.import(file)
    if file
      CSV.foreach(file.path, headers: true) do |row|
        puts row.headers
      
        Contact.create! row.to_hash
      end
    end
  end

  def self.to_csv
    attributes = %w[full_name last_names email phone_number position salary department]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |employee|
        csv << employee.attributes.values_at(*attributes)
      end
    end
  end


  def correct_date_of_birth_format
    if VALID_DATE_OF_BIRTH_REGEX_1.match(date_of_birth) ||
       VALID_DATE_OF_BIRTH_REGEX_2.match(date_of_birth)
      begin
        birthdate.to_date
      rescue => e
        errors.add(:birthdate, "wrong date value")
      end
    else
      errors.add(:birthdate, "wrong date format")
    end
  end

  def correct_phone_format
    unless (VALID_PHONE_NUMBER_REGEX_1.match(phone_number) ||
            VALID_PHONE_NUMBER_REGEX_2.match(phone_number))
      errors.add(:phone, "wrong phone format")
    end
  end
end
  
