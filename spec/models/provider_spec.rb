require 'rails_helper'

RSpec.describe Provider, type: :model do
  it 'is valid with valid attributes' do
    provider = FactoryBot.build(:provider)
    expect(provider).to be_valid
  end

  it 'is not valid without a name' do
    provider = FactoryBot.build(:provider, name: nil)
    expect(provider).to_not be_valid
  end

  it 'is not valid without a nit' do
    provider = FactoryBot.build(:provider, nit: nil)
    expect(provider).to_not be_valid
  end

  it 'is not valid without a contact_name' do
    provider = FactoryBot.build(:provider, contact_name: nil)
    expect(provider).to_not be_valid
  end

  it 'is valid without a contact_phone' do
    provider = FactoryBot.build(:provider, contact_phone: nil)
    expect(provider).to be_valid
  end

  it 'accepts nested attributes for bank_account' do
    provider = FactoryBot.build(:provider)
    expect(provider).to accept_nested_attributes_for(:bank_account)
  end
end