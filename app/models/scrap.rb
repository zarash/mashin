class Scrap < ActiveRecord::Base
  belongs_to :site

  def sweep
  	page_num = 1
  	self.count = 0

		begin 
		  url = self.url + "#{page_num}"

			doc = Nokogiri::HTML(open(url))
			single_page_sweep(doc)

		  page_num = page_num +1 
		end while self.count > 5
	end


private
	def single_page_sweep(doc)
		
    doc.css('.center a.grid').each do |tag|

      url_single = tag["href"]

      doc_single = Nokogiri::HTML(open(url_single))

      ad = single_ad_sweep(doc_single)

	    Ad.create(
        price: ad_hash[:price], 
        year: ad_hash[:year], 
        details: ad_hash[:details], 
        girbox: ad_hash[:girbox], 
        millage: ad_hash[:millage],
        origin_url: ad_hash[:url_single],
        fuel: ad_hash[:fuel],
        usage_type: ad_hash[:usage_type],
        body_color_id: ad_hash[:body_color_id],
        internal_color_id: ad_hash[:internal_color_id],

        active: true
      )
    end
	end

	def single_ad_sweep doc_single
    girbox_arr = ["دنده ای", "اتوماتیک"]
    fuel_arr = ["بنزین", "دوگانه سوز", "هایبرید", "دیزل"]  
    colors = [ "آبي",    "قرمز",   "سبز",    "نارنجي",   "سفيد",   "مشکي",   "آلبالوئی",   "اخرائی",   "اطلسی",    "بادمجانی",   "بژ",   "بنفش",   "پوست پیازی",   "خاکستری",    "خاکی",   "زرد",    "زرشکی",    "سربی",   "سرمه ای",    "صورتی",    "طلائی",    "عدسی",   "عنابی",    "قهوه ای",    "کرم",    "مسی",    "نقرآبی",   "نقره ای",    "نوک مدادی",    "یشمی",   "مارون",    "طوسی",   "زیتونی",   "شتری",   "برنز",   "دلفینی",   "گیلاسی",   "یاسی"]

    ad = {}
    ad_hash[:tel] = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblCellphoneNumber').text

    price = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblPrice')
    ad_hash[:price] = (price.text.gsub! ",", "").to_i

    millage = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblMilage')
    ad_hash[:millage] = millage.text.to_i

    ad_hash[:details] = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblDescr').text

    girbox_type = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblGearboxType')
    ad_hash[:girbox] = girbox_arr.index girbox_type.text

    fuel = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblFuelType')
    ad_hash[:fuel] = fuel_arr.index fuel.text

    body_color_id = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblExColor')
    ad_hash[:body_color_id] = colors.index body_color_id.text
    internal_color_id = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblInColor')
    ad_hash[:internal_color_id] = colors.index internal_color_id.text


    feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
    year = feature.text.split("،")[0].to_i
    if year < 1900
      ad_hash[:year] = JalaliDate.new(year,10,15).to_g
    else
      ad_hash[:year] = ("#{year}-1-1").to_date
    end
    # ad_hash[:carmodel = feature.text.split("،")[1]
    # brand = feature.text.split("،")[2]

    if price == 0 && millage == 0
      ad_hash[:usage_type] = 2
    elsif millage == 0
      ad_hash[:usage_type] = 1
    else
      ad_hash[:usage_type] = 0
    end

    date = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblDate')
    if date != "امروز"
    	self.count = self.count + 1
    else
    	self.count = 0
    end
    
    ad_hash
  end

end
