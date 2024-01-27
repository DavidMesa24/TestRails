class Provider < ApplicationRecord
  has_one :bank_account, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :nit, presence: true, uniqueness: true, length: { maximum: 12 }, format: { with: /\A\d{9}(-\d)?\z/ }
  validates :contact_name, presence: true, length: { maximum: 50 }
  validates :contact_phone, length: { maximum: 10 }

  accepts_nested_attributes_for :bank_account, allow_destroy: true

  def attribute_validator(value)
    value.blank? ? I18n.t('errors.not_found') : value
  end

  private

  def self.whit_bank_account
    includes(:bank_account => :bank)
  end
end