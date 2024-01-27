FactoryBot.define do
  factory :provider do
    name { Faker::Company.name }
    nit { Faker::Number.unique.number(digits: 9).to_s + "-#{Faker::Number.digit}" }
    contact_name { Faker::Name.name }
    contact_phone { Faker::PhoneNumber.cell_phone[0...10] }
    bank_account { build :bank_account }
    end
end