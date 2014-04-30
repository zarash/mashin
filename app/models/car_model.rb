class CarModel < ActiveRecord::Base
  belongs_to :make
  default_scope order('name')
end
