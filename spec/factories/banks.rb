FactoryBot.define do
  factory :bank do
    id { 1 }
    name { Faker::Bank.name }
  end
end