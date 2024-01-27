require 'rails_helper'

RSpec.describe Bank, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  it 'has a valid factory' do
    bank = FactoryBot.build(:bank)
    expect(bank).to be_valid
  end

  it 'is invalid if name is longer than 50 characters' do
    bank = FactoryBot.build(:bank, name: 'a' * 51)
    expect(bank).to_not be_valid
  end

  it 'is invalid if name is not unique' do
    bank = FactoryBot.create(:bank)
    bank2 = FactoryBot.build(:bank, name: bank.name)
    expect(bank2).to_not be_valid
  end

  it 'is invalid if name is blank' do
    bank = FactoryBot.build(:bank, name: '')
    expect(bank).to_not be_valid
  end

  it 'is invalid if name is nil' do
    bank = FactoryBot.build(:bank, name: nil)
    expect(bank).to_not be_valid
  end
end