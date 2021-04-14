FactoryBot.define do
  factory :failcontact do
    full_name { "MyString" }
    address { "MyString" }
    date_of_birth { "MyString" }
    credit_card { "MyString" }
    email { "MyString" }
    phone_number { "MyString" }
    franchise { "MyString" }
    user_id { 1 }
    error_data { "MyText" }
  end
end
