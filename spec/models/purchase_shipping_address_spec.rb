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
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号が3桁ハイフン4桁でないと保存できない' do
        @purchase_shipping_address.post_code = '1112222'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号は半角数字で入力してください。郵便番号はハイフン(-)が必要です')
      end
      it '郵便番号が半角文字列でないと保存できない' do
        @purchase_shipping_address.post_code = '１１１−2222'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号は半角数字で入力してください。郵便番号はハイフン(-)が必要です')
      end
      it '都道府県が選択されていないと保存できない' do
        @purchase_shipping_address.area_id = 1
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it '市区町村が空だと保存できない' do
        @purchase_shipping_address.city = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it '番地が空だと保存できない' do
        @purchase_shipping_address.address = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が空だと保存できない' do
        @purchase_shipping_address.phone_number = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号が10桁未満だと保存できない' do
        @purchase_shipping_address.phone_number = '111111111'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号を10桁から11桁で入力してください')
      end
      it '電話番号が12桁以上だと保存できない' do
        @purchase_shipping_address.phone_number = '111122223333'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号を10桁から11桁で入力してください')
      end
      it '電話番号が半角数値でないと保存できない' do
        @purchase_shipping_address.phone_number = '１１１１２２２２１１１'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号を10桁から11桁で入力してください')
      end
      it 'user_idが紐づいていないと保存できない' do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idが紐づいていないと保存できない' do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Itemを入力してください')
      end
      it 'tokenが空では保存できない' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
    end
  end
end
