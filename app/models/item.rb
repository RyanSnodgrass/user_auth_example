class Item < ActiveRecord::Base
	belongs_to :wishlist

	after_create :get_etsy_id
	
	def get_etsy_id
		string = self.etsy_url
		regex = /\d+/
		numbers = string.scan(regex)
		self[:etsy_id] = numbers[0]
		self.save #save in the DB
	end
end

