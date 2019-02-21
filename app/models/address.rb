class Address < ApplicationRecord
	has_many :customers, inverse_of: :address

	validates :street, presence: true
end
