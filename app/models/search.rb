class Search
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
	attr_accessor :make, :car_model, :fuel, :millage, :girbox,
								:year_from, :year_to,
								:price_from, :price_to,
								:usage_type, :exchange


	def initialize attributes ={}
    unless attributes.nil?
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
	end

  def persisted?
    false
  end

	def self.inspect
	  "#<#{ self.to_s} #{ self.attributes.collect{ |e| ":#{ e }" }.join(', ') }>"
	end

	def new_ads
		Ad.all
	end

private


end