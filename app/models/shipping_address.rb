class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :purchase

  # validates :post_code, presence: true
  # validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
  # validates :city, presence: true
  # validates :address, presence: true
  # validates :phone_number, presence: true
end
