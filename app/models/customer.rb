class Customer < ApplicationRecord
	belongs_to :address, optional: true, inverse_of: :customers

	validates :name, presence: true

  accepts_nested_attributes_for :address

	class << self
		def filter_by(filter, condition = {})
			results = self
			results = self.where("name LIKE ?", "%#{filter[:name]}%") if filter[:name].present?
			results = results.joins(:address).where("addresses.street LIKE ?", "%#{filter[:street]}%") if filter[:street].present?

			return results
		end
	end
end
