module ApplicationHelper

	def flash_creator flash
		message= "";
		flash.each do |name, msg| 	
			case name
				when :notice    
				  message += "<div class=\"alert alert-success\">#{msg}</div>"	
				when :warning    
				  message += "<div class=\"alert alert-warning\">#{msg}</div>"	
				when :error, :alert
				  message += "<div class=\"alert alert-danger\">#{msg}</div>"
				else
				  message += "<div class=\"alert alert-info\">#{msg}</div>"			
			end
	 	end 
	 	message.html_safe
	end
  
  def km_range
  	a = (1000..10000).step(1000).map{|s| [ ("#{number_to_human s} #{t("kilometer")}") , s]}
  	b = ((20000..100000).step(10000)).map{|s| [("#{number_to_human s} #{t("kilometer")}") , s]}
  	c = ((200000..1000000).step(100000)).map{|s| [("#{number_to_human s} #{t("kilometer")}") , s]}
  	last = ((2000000..4000000).step(100000)).map{|s| [("#{number_to_human s} #{t("kilometer")}") , s]}

  	a.concat(b).concat(c).concat(last)
  	# raise
  end

  def price_range
  	a = (1000000.0..10000000.0).step(1000000.0).map{|s| [ ("#{number_to_human s} #{t("toman")}") , s]}
  	b = ((20000000.0..100000000.0).step(10000000.0)).map{|s| [("#{number_to_human s} #{t("toman")}") , s]}
  	c = ((2000000000.0..10000000000.0).step(1000000000.0)).map{|s| [("#{number_to_human s} #{t("toman")}") , s]}

  	a.concat(b).concat(c)
  	# raise
  end

  def year_range
  	a = [[ "", ""]]
  	b = ( 1330..(JalaliDate.new(Date.today).year) ).map{|s| [ s, s]}
  	a.concat b
  end

  def error_messages_for(object)
    render(:partial => 'application/error_messages',
      :locals => {:object => object})
  end

end
