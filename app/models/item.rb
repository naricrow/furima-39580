class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :shipping_date
  belongs_to :user

  has_one_attached :image
  #has_one :purchase

  validates :image, presence: true
  validates :name, presence: true
  validates :content, presence: true
  validates :area_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :category_id, numericality: { other_than: 1 ,message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :charge_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_date_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/, message: "is not a number" }
end
