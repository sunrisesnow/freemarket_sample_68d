FactoryBot.define do
  factory :address do
    last_name             { ForgeryJa(:name).last_name }
    first_name            { ForgeryJa(:name).first_name }
    last_name_kana        { ForgeryJa(:name).last_name(to: ForgeryJa::KANA) }
    first_name_kana       { ForgeryJa(:name).first_name(to: ForgeryJa::KANA) }
    postal_code           { Faker::Number.number(digits: 7).to_s }
    prefectures           { Faker::Number.between(from: 1, to: 47) }
    municipality          { "足立区" }
    address               { "123-456" }
    phone_number          { "0123456789" }
  end
end