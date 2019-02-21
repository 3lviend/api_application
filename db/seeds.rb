# Create initials address
addresses = [
  {street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code},
  {street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code},
  {street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code}
]

Address.create(addresses)

# Customers with existing address id
customers = [
  {name: Faker::Name.name, address_id: Address.all.sample.id},
  {name: Faker::Name.name, address_id: Address.all.sample.id},
  {name: Faker::Name.name, address_id: Address.all.sample.id}
]

Customer.create(customers)

# Customers with new address
customers = [
  {
    name: Faker::Name.name, address_attributes: {
      street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code
    }
  },
  {
    name: Faker::Name.name, address_attributes: {
      street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code
    }
  },
  {
    name: Faker::Name.name, address_attributes: {
      street: Faker::Address.street_name, city: Faker::Address.city, zip_code: Faker::Address.zip_code
    }
  }
]

Customer.create(customers)
