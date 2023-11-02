FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { 'a1' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { '山まダ' }
    last_name             { '太ろウ' }
    first_name_kana       { 'ヤマダ' }
    last_name_kana        { 'タロウ' }
    birthday              { Faker::Date.between(from: '1930-1-1', to: '2018-12-31') }
  end
end
