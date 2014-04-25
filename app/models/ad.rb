class Ad < ActiveRecord::Base
	has_one :ad_other_field

  belongs_to :user
  belongs_to :car_model
  belongs_to :scrap

end
