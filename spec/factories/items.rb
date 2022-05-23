FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    content { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 12) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    quality_id { Faker::Number.between(from: 2, to: 7) }
    shipping_charge_id { Faker::Number.between(from: 2, to: 3) }
    shipment_source_id { Faker::Number.between(from: 2, to: 48) }
    date_shipment_id { Faker::Number.between(from: 2, to: 4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
