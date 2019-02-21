# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryBot.define do
  factory :customer do
    name {Faker::Name.name}
    address do
      FactoryBot.create(:address, street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code)
    end
  end
end
