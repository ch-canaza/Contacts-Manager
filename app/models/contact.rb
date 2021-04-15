class Contact < ApplicationRecord
  include BCrypt
  include Sidekiq::Worker
  
  belongs_to :user

  VALID_PHONE_NUMBER = /\A[0-9]+\Z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[a-zA-Z -]+\z/
  VALID_DATE_OF_BIRTH_REGEX_1 = /\A\d{4}-\d{2}-\d{2}\z/
  VALID_DATE_OF_BIRTH_REGEX_2 = /\A\d{4}\d{2}\d{2}\z/
  VALID_PHONE_NUMBER_REGEX_1 = /\A\(\+\d{2}\) \d{3} \d{3} \d{2} \d{2}\z/
  VALID_PHONE_NUMBER_REGEX_2 = /\A\(\+\d{2}\) \d{3}-\d{3}-\d{2}-\d{2}\z/

  VALID_VISA_IIN = /\A^4[0-9]{6,}$\Z/
  VALID_AMERICAN_EXPRESS_IIN = /\A^3[47][0-9]{5,}$\Z/
  VALID_DINNERS_CLUB_IIN = /\A^3(?:0[0-5]|[68][0-9])[0-9]{4,}$\Z/
  VALID_DISCOVER_IIN = /\A^6(?:011|5[0-9]{2})[0-9]{3,}$\Z/
  VALID_MASTER_CARD_INN = /\A^5[1-5][0-9]{7}\Z/

  validate :correct_phone_format
  #validate :correct_date_of_birth_format
  validate :a_valid_franchise?

  validates :full_name,
            presence: true,
            format: {with: VALID_NAME_REGEX },
            length: { maximum: 75 }
  validates :date_of_birth,
            presence: true,
            format: { with: VALID_DATE_OF_BIRTH_REGEX_1 }
  validates :phone_number,
            presence: true
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
            uniqueness: { scope: :credit_card, message: 'already exists in the database' },
            length: { minimum: 3, maximum: 35 },
            format: { with: VALID_EMAIL_REGEX }

  has_one_attached :csv_file

  
  def card_number
    @card_number ||= Password.new(card_number_hash) if card_number_hash.present?
  end

  def card_number=(new_card_number)
   @card_number = new_card_number
    self.card_number_hash = @card_number
  end

  def self.import(file, user)
    if user

      $success = false
      CSV.foreach(file, headers: true) do |row|
        puts row.headers
        puts row
        $headers = row.headers
        if user.contacts.create! row.to_hash
          $success = true
          puts 'saved'
          $data_location = 'Contacts list'
        else
          puts 'data has duplicated'
          $data_location = 'Fails list'
          user.failcontacts.create! row.to_hash
        end
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
        date_of_birth.to_date
      rescue
        errors.add(:date_of_birth, "rong date value")
      end
    else
      errors.add(:date_of_birth, "wrong date format")
    end
  end

  def correct_phone_format
    unless (VALID_PHONE_NUMBER_REGEX_1.match(phone_number) ||
            VALID_PHONE_NUMBER_REGEX_2.match(phone_number))
      errors.add(:phone, "wrong phone format")
    end
  end

  def correct_card_franchise_based_on_iin_format
    return 'visa' if VALID_VISA_IIN.match(credit_card)
    return 'dinners club' if VALID_DINNERS_CLUB_IIN.match(credit_card)
    return 'master card' if VALID_MASTER_CARD_INN.match(credit_card)
    return 'american express' if VALID_AMERICAN_EXPRESS_IIN.match(credit_card)
    return 'discover' if VALID_DISCOVER_IIN.match(credit_card)

    nil
  end

  private

  def a_valid_franchise?
    if correct_card_franchise_based_on_iin_format.nil?
      errors.add(:credit_card, :invalid)
      false
    else
      $franchise = correct_card_franchise_based_on_iin_format
    end
  end

end
