FactoryBot.define do
  factory :purchase_shipping_address do
    post_code { '123-4567'}
    area_id { 2 }
    city { '東京市'}
    address {'東京1-2'}
    building_name { '栃木ハイツ' }
    phone_number { 1234567891 }
    token { "tok_abcdefjk000000000000"}
  end
end
