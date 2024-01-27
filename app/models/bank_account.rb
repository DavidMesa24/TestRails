class BankAccount < ApplicationRecord
  belongs_to :provider
  belongs_to :bank, foreign_key: :bank_id, inverse_of: :bank_accounts

  validates :account_number, presence: true, uniqueness: true
  validates :bank_id, presence: true
end