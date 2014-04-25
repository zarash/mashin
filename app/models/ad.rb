class Ad < ActiveRecord::Base
  belongs_to :user
  belongs_to :carmodel
  belongs_to :scrap
end
