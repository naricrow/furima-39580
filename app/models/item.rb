class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :shipping_date
  belongs_to :user

  has_one_attached :image
  has_one :purchase

  validates :image, presence: true
  validates :name, presence: true
  validates :content, presence: true
  validates :area_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :charge_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_date_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
