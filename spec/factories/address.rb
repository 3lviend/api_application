# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryBot.define do
  factory :address do
    street {Faker::Address.street_name}
    city {Faker::Address.city}
    zip_code {Faker::Address.zip_code}
  end

end
