require 'rails_helper'
require 'faker'

RSpec.describe Address, type: :model do
  context 'Create new address with invalid data' do
    it 'cannot create address' do
      expect { Address.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'Create new address with valid data' do
    it 'Can create address' do
      @address = Address.create(street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code)

      expect(!@address.new_record?)
      expect(@address.customers).to match([])
    end
  end
end
