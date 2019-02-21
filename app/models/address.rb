class Address < ApplicationRecord
	has_many :customers

	validate :street, presence: true
end
