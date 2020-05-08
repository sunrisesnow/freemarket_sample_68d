FactoryBot.define do
  
  factory :image do
    image   { File.open("#{Rails.root}/public/images/rspec.jpg")}
    association  :item, factory: :item
  end
end