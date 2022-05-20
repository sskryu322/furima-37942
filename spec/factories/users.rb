FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { '太郎' }
    first_name { '山田' }
    last_name_pseudonym_reading { 'タロウ' }
    first_name_pseudonym_reading { 'ヤマダ' }
    birthday { '1999-01-01' }
  end
end
