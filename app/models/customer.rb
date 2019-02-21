class Customer < ApplicationRecord
	belongs_to :address, optional: true

	validate :name, presence: true

	class << self
		def filter_by(filter, condition = {})
			results = Customer.all

			results = results.where("name LIKE ?", "%#{filter[:name]}%") if filter[:name].present?
			results = results.joins(:address).where("addresses.street LIKE ?", "%#{filter[:street]}%") if filter[:street].present?

			return results
		end
	end
end
