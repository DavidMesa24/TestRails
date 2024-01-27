class Bank < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  before_update :validates_length_of_name

  private

  def validates_length_of_name
    if name.length > 50
      errors.add(:name, "can't be longer than 50 characters")
    end
  end
end
