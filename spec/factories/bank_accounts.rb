FactoryBot.define do
  factory :bank_account do
    account_number { Faker::Bank.account_number(digits: 10) }
    bank { build :bank } if Bank.count.zero?
    bank_id { 1 } || Bank.first.id
  end
end