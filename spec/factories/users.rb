FactoryBot.define do
  
  factory :user do
    password = Faker::Internet.password(min_length: 7)
    email {Faker::Internet.email}
    password {password}
    password_confirmation {password}
    nickname {Faker::Name.name}
    last_name {Faker::Name.name}
    first_name {Faker::Name.name}
    last_name_kana {"テスト"}
    first_name_kana {"メルカリ"}
    birthday {Faker::Date.birthday}
    icon_image {"test.jpg"}
  end
end