FactoryBot.define do
  factory :purchase_address do
    postal_code { '123-4567' }
    shipment_source_id { Faker::Number.between(from: 2, to: 48) }
    municipality { '東京区' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    telephone_number { Faker::Number.between(from: 1_111_111_111, to: 99_999_999_999) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
