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

	def set_name_from_etsy
		etsy_data = get_etsy_data
		self[:name] = etsy_data["results"][0]["title"]
		self.save
	end

	def set_description_from_etsy
		etsy_data = get_etsy_data
		self[:description] = etsy_data["results"][0]["description"]
		self.save
	end

	def get_etsy_data
		response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{self.etsy_id}?api_key=#{Rails.application.secrets.etsy_api_key}")
	end
end

