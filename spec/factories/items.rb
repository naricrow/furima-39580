FactoryBot.define do
  factory :item do
    name    { 'かばん'}
    content {Faker::Lorem.sentence}
    category_id { 2 }
    condition_id { 2 }
    charge_id { 2 }
    area_id { 2 }
    shipping_date_id { 2 }
    price { 1000 }
    association :user
  
    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test.jpg'), filename: 'test.jpg', content_type: 'image/jpeg')
    end
  end
end
