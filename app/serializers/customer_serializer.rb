class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :address_detail

  def name
  	return object.name
  end

  def address_detail(data = [])
  	address = object.address

  	address_data = {
  		id: address.id,
  		street: address.street,
  		city: address.city,
  		zip_code: address.zip_code,
  	}

  	data << address_data

  	return data
  end
end
