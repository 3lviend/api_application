require 'rails_helper'
require 'faker'

RSpec.describe Customer, type: :model do
  context 'Create new customer with invalid data' do
    it 'cannot create customer' do
      expect { Customer.create! }.to raise_error(ActiveRecord::RecordInvalid)  # test code
    end
  end

  context 'Create new customer with valid data' do
    it 'Can create customer with existing address' do
      @customer = Customer.new(name: Faker::Name.name, address_id: Address.all.sample.id)

      expect(@customer.new_record?)
      @customer.save
      expect(!@customer.new_record?)
      expect(@customer.address.present?)
    end

    it 'Can create customer with new address' do
      @customer = Customer.new(name: Faker::Name.name, address_attributes: {street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code})

      expect(@customer.new_record?)
      @customer.save
      expect(!@customer.new_record?)
      expect(@customer.address.present?)
    end
  end

  context 'Filter customer' do
    it 'Filter customer with existing name' do
      filter = {name: Customer.all.sample.name}

      @customers = Customer.filter_by(filter)

      expect(@customers.present?)
      expect(@customers.map(&:name).include?(filter[:name]))
    end

    it 'Filter customer with existing address street' do
      filter = {street: Address.all.sample.street}

      @customers = Customer.filter_by(filter)

      expect(@customers.present?)
      expect(@customers.map{|customer| customer.address.street}.include?(filter[:street]))
    end

    it 'Filter customer with existing name and address street' do
      customer = Customer.all.sample
      filter = {name: customer.name, street: customer.address.street}

      @customers = Customer.filter_by(filter)

      expect(@customers.present?)
      expect(@customers.map(&:name).include?(filter[:name]))
      expect(@customers.map{|customer| customer.address.street}.include?(filter[:street]))
    end

    it 'Filter customer with not registered name and not registered address street' do
      filter = {name: Faker::Name.name, street: Faker::Address.street_name}

      @customers = Customer.filter_by(filter)

      expect(@customers.present?)
      expect(@customers.map(&:name).include?(filter[:name]))
      expect(@customers.map{|customer| customer.address.street}.include?(filter[:street]))
    end
  end
end
