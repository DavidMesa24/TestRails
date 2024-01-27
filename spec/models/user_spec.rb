require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  it 'should have a valid factory' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user = FactoryBot.build(:user, first_name: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without a last name' do
    user = FactoryBot.build(:user, last_name: nil)
    expect(user).to_not be_valid
  end

  describe 'devise validations' do
    it 'is invalid without an email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without a password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid with a short password' do
      user = FactoryBot.build(:user, password: '123')
      expect(user).to_not be_valid
    end
  end
end