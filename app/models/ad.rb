class Ad < ActiveRecord::Base

  geocoded_by :location
  # after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }
  
	has_one    :ad_other_field
	has_many   :image_urls

  belongs_to :user
  belongs_to :car_model
  belongs_to :make
  belongs_to :scrap

  def car_model_name
    Rails.cache.fetch([:car_model, car_model_id, :name], expires_in: 5.minutes) do 
      car_model.name
    end
  end

  def make_name
    Rails.cache.fetch([:make, :make, :name], expires_in: 5.minutes) do 
      make.name
    end
  end

  def big_images
    if self.user_id.nil?
      self.image_urls
    else
      # self.images
    end
  end

end
