class Location < ActiveRecord::Base
  geocoded_by :name
  after_validation :geocode, if: ->(obj){ (obj.locked==false) and obj.name.present? and obj.name_changed? }
 
 end
