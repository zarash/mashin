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
  end

  def price_range
    unit = 1000000.0
  	a = ( ( (unit*1   )..(unit*10  ) ).step(unit*1)    ).map{|s| [("#{number_to_human s} #{t("toman")}") , s]}
  	b = ( ( (unit*20  )..(unit*100 ) ).step(unit*10)   ).map{|s| [("#{number_to_human s} #{t("toman")}") , s]}
    c = ( ( (unit*200 )..(unit*1000) ).step(unit*100)  ).map{|s| [("#{number_to_human s} #{t("toman")}") , s]}
  	d = ( ( (unit*2000)..(unit*5000) ).step(unit*1000) ).map{|s| [("#{number_to_human s} #{t("toman")}") , s]}

  	a.concat(b).concat(c).concat(d)
  end

  def year_range
  	a = [[ "", ""]]
    this_year = JalaliDate.new(Date.today).year
  	b = ( (this_year).downto(1330) ).map{|s| [ s, s]}
  	a.concat b
  end

  def error_messages_for(object)
    render(:partial => 'application/error_messages',
      :locals => {:object => object})
  end

  def price_human amount
    (amount != 0) ? number_to_human(amount, precision: 6, separator: "/")  : t("undifinded")
  end

  def date_human date
    # if date > DateTime.now - 24.hours
    #   t "today"
    # else
      "#{time_ago_in_words(date) } #{t("ago")}"
    # end

  end

  def last_search
    cookies[:last_search] ? Search.find( cookies[:last_search]) : root_url
  end

  def title_creator search
    title = "خرید و فروش خودرو "
    title = title + " #{search.make.name}"  if search.make_id
    title = title + " #{search.car_model.name}" if search.car_model_id     
    title
  end

  def ad_title ad
    if ad.make_id
      title = " "
      title = "<span class='pull-right title_element'>#{ad.make_name}، &nbsp;</span>"  if ad.make_name
      title = title + " <span class='pull-right title_element'>#{ad.car_model_name}،&nbsp;</span>" if ad.car_model_name.present?     
      title = title + " <span class='pull-right title_element'>#{appropriate_year(ad) }</span> <br>" if ad.year or ad.usage_type==1           
    else
      title = ad.ad_other_field.title
    end
    title.try(:html_safe)
  end

end
