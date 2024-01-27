class Bank < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
