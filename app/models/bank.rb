class Bank < ApplicationRecord
  validates :name, presence: true, uniqueness: {message: 'is already in use. Please choose a different one.'}, length: { maximum: 50 }
end
