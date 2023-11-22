require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
   before do
     user = FactoryBot.create(:user)
     item = FactoryBot.create(:item)
     @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: user.id, item_id: item.id)
     sleep(0.1)
   end
  describe '購入情報の保存' do
    context '購入情報が保存できる場合' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@purchase_shipping_address).to be_valid
      end
      it 'building_nameはからでも保存できる' do
        @purchase_shipping_address.building_name = ''
        expect(@purchase_shipping_address).to be_valid
      end
    end
    context '購入情報が保存できない場合' do
      it '郵便番号が空だと保存できない' do
        @purchase_shipping_address.post_code = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号が3桁ハイフン4桁でないと保存できない' do
        @purchase_shipping_address.post_code = '1112222'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '郵便番号が半角文字列でないと保存できない' do
        @purchase_shipping_address.post_code = '１１１−2222'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '都道府県が選択されていないと保存できない' do
        @purchase_shipping_address.area_id = 1
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Area can't be blank")
      end
      it '市区町村が空だと保存できない' do
        @purchase_shipping_address.city = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できない' do
        @purchase_shipping_address.address = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @purchase_shipping_address.phone_number = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が10桁未満だと保存できない' do
        @purchase_shipping_address.phone_number = '111111111'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号が12桁以上だと保存できない' do
        @purchase_shipping_address.phone_number ='111122223333'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号が半角数値でないと保存できない' do
        @purchase_shipping_address.phone_number ='１１１１２２２２１１１'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'user_idが紐づいていないと保存できない' do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていないと保存できない' do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
