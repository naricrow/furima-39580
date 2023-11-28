class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :area_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は半角数字で入力してください。郵便番号はハイフン(-)が必要です' }
    validates :area_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'を10桁から11桁で入力してください' }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    ShippingAddress.create(post_code:, area_id:, city:, address:, building_name:,
                           phone_number:, purchase_id: purchase.id)
  end
end
