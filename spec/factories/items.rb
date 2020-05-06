FactoryBot.define do
  
  factory :item, class: Item do
    # buyer_id
    # saler_id
    name {Faker::Name.name}
    explanation {Faker::Lorem.sentence}
    delivery_charge_flag {Faker::Number.between(from: 1, to: 2)}
    price {Faker::Number.between(from: 300, to: 9999999)}
    prefecture_id {Faker::Number.between(from: 1, to: 47)}
    status_id {Faker::Number.between(from: 1, to: 6)}
    delivery_date_id {Faker::Number.between(from: 1, to: 3)}
    # delivery_method_id {Faker::Number.between(from: 1, to: 2)}
    trading_status_id {1}
    # category
    created_at { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now) }
    after(:build) do |item|
      item.images<< build(:image, item: item)
    end
  end

  factory :item_has_many_images, class: Item do
    # buyer_id
    # saler_id
    name {Faker::Name.name}
    explanation {Faker::Lorem.sentence}
    delivery_charge_flag {Faker::Number.between(from: 1, to: 2)}
    price {Faker::Number.between(from: 300, to: 9999999)}
    prefecture_id {Faker::Number.between(from: 1, to: 47)}
    status_id {Faker::Number.between(from: 1, to: 6)}
    delivery_date_id {Faker::Number.between(from: 1, to: 3)}
    # delivery_method_id {Faker::Number.between(from: 1, to: 2)}
    trading_status_id {1}
    # category
    created_at { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now) }
    after(:build) do |item|
      item.images<< build(:image, item: item)
    end
    after(:build) do |item|
      item.images<< build(:image, item: item)
    end
  end  

  factory :item_no_images, class: Item do
    # buyer_id
    # saler_id
    name {Faker::Name.name}
    explanation {Faker::Lorem.sentence}
    delivery_charge_flag {Faker::Number.between(from: 1, to: 2)}
    price {Faker::Number.between(from: 300, to: 9999999)}
    prefecture_id {Faker::Number.between(from: 1, to: 47)}
    status_id {Faker::Number.between(from: 1, to: 6)}
    delivery_date_id {Faker::Number.between(from: 1, to: 3)}
    # delivery_method_id {Faker::Number.between(from: 1, to: 2)}
    trading_status_id {1}
    # category
    created_at { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now) }
  end
end