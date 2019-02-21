class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :address_details

  def address_details(data = {})
    address = object.address
    if address.present?
      data[:id]       = address.id
      data[:street]   = address.street
      data[:city]     = address.city
      data[:zip_code] = address.zip_code
    end

    return data
  end
end
