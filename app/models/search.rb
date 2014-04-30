class Search < ActiveRecord::Base
  # geocoded_by :location
  # after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }
  
	belongs_to :make
	belongs_to :car_model

	def year_from_shamsi
		year_from ? JalaliDate.new(year_from).year : ""
	end

	def year_to_shamsi
		year_to   ? JalaliDate.new(year_to).year : ""
	end

  def ads
    @ads ||= find_ads
  end

  def count
    @ads = ads.to_a.size
  end

private

	def find_ads
		ads = Ad.all.includes(:car_model, car_model: :make)
		ads = ads.order(find_order) if order.present?
		
		ads = ads.where("year >= ?", year_from) if year_from.present?
		ads = ads.where("year <= ?", year_to) if year_to.present?

		ads = ads.where("price >= ?", price_from ) if price_from.present?
		ads = ads.where("price <= ?", price_to ) if price_to.present?

		ads = ads.where("millage >= ?", millage_from) if millage_from.present?
		ads = ads.where("millage <= ?", millage_to) if millage_to.present?

		ads = ads.near(find_location, find_radius , :units => :km) if find_location.first 

		ads = ads.where(make_id: make_id) if make_id.present?
		ads = ads.where(car_model_id: car_model_id) if car_model_id.present?
		ads
	end

	def find_order
		case self.order
		when 'year'
			"year DESC"
		when "cheap"
			"price ASC"
		when "expencive"
			"price DESC"
		else
			"created_at DESC"
		end
	end

	def find_radius
		 self.radius ? self.radius : 10
	end

	def find_location
    myloc = Location.where(name: self.location).first
    if myloc && myloc.latitude
      lat = myloc.latitude
      lng = myloc.longitude
    else
      loc = Geocoder.search(self.location)[0]
      lat = loc.try(:latitude)
      lng = loc.try(:longitude)
      Location.create(name: self.location, latitude: lat, longitude: lng)  if lng
    end
    [lat, lng]
	end
end
