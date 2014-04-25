class Ad < ActiveRecord::Base
	has_one    :ad_other_field
	has_many   :image_urls

  belongs_to :user
  belongs_to :car_model
  belongs_to :scrap

end
