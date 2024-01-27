# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Provider.destroy_all
Bank.destroy_all

80.times do
  begin
    bank = Bank.create!(name: Faker::Bank.name[0..49])
    puts "Bank created: #{bank.name}"
  rescue StandardError => e
    puts "Error creating bank: #{e.message}"
  end
end

# Create 20 providers with associated bank accounts
80.times do
  begin
    provider = Provider.create!(
      name: Faker::Company.name[0..49],
      bank_account: BankAccount.create(
        bank: Bank.all.sample,
        account_number: Faker::Bank.account_number(digits: 10)
      ),
      nit: Faker::Number.unique.number(digits: 9).to_s + "-#{Faker::Number.digit}",
      contact_name: Faker::Name.name[0..49],
      contact_phone: Faker::PhoneNumber.cell_phone[0...10]
    )
    puts "Provider created: #{provider.name}"
  rescue StandardError => e
    puts "Error creating provider: #{e.message}"
  end
end
