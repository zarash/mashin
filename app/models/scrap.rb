class Scrap < ActiveRecord::Base
  belongs_to :site
  has_many   :ads

  def sweep
    page_num = 1
    self.count = 0
    url = self.url
    @terminate = false
    begin 
      url = self.url.gsub "my_page_counter", "#{page_num}"
      doc = Nokogiri::HTML(open(url))
      single_page_sweep(doc)
      page_num = page_num +1 
      break if @terminate 
    end while true 
  end

private
  
  def single_page_sweep(doc)
    
    index_page_row(doc).each do |tag|

      url_single = tag["href"]

      doc_single = Nokogiri::HTML(open(url_single))
      
      next if skip_condition? doc_single, url_single

      if termination_check(doc_single)
        @terminate = true 
        # break
      end

      ad_hash = single_ad_sweep(doc_single)

      ad = create_ad(ad_hash)

      build_ad_other_field_record(ad, url_single, ad_hash)

      build_ad_images(ad, doc_single)

    end

  end
    
  def build_ad_images(ad, doc_single)
    doc_single.css('#ctl00_cphMain_SelectedAdImages1_pnlImage div>img.AdImagefader').each do |img|
      url = img["src"].gsub "../..", "http://www.bama.ir"

      build_ad_image(ad, url)
    end
  end

  def build_ad_image(ad, url)
    unless url.include? "AdImages/Default-Car"
      ad.image_urls.build( url:  url)
      ad.save      
    end
  end

  def build_ad_other_field_record(ad, url_single, ad_hash)
      ad.build_ad_other_field(
        source_url:  url_single,
        thumb_img:   ad_hash[:thumb_img],
        tel:         ad_hash[:tel]
      )
      ad.save  
  end

  def create_ad ad_hash
      ad = self.ads.build(
        make_id:           ad_hash[:make_id], 
        car_model_id:      ad_hash[:car_model_id], 
        price:             ad_hash[:price], 
        year:              ad_hash[:year], 
        year_format:       ad_hash[:year_format], 
        details:           ad_hash[:details], 
        girbox:            ad_hash[:girbox], 
        millage:           ad_hash[:millage],
        fuel:              ad_hash[:fuel],
        usage_type:        ad_hash[:usage_type],
        body_color_id:     ad_hash[:body_color_id],
        internal_color_id: ad_hash[:internal_color_id],
        location:          ad_hash[:location],
        latitude:          ad_hash[:latitude], 
        longitude:         ad_hash[:longitude], 
        active:            true
      )
      ad.save
      ad
  end

  def skip_condition? doc_single, url_single
    flag = false
    if self.name == "bama"
      feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
    elsif self.name == "takhtegaz"
      feature = doc_single.css('#df_field_title .value')
    end

    flag = true if feature.blank?

    if AdOtherField.where(source_url: url_single).first
      flag = true
    end
    flag
  end

  def single_ad_sweep doc_single
    ad_hash = {}

    ad_hash[:tel] = tel doc_single

    ad_hash[:thumb_img] = thumb_img doc_single

    ad_hash[:price] = price doc_single

    ad_hash[:millage] = millage doc_single

    ad_hash[:details] = details doc_single

    ad_hash[:girbox] = girbox doc_single

    ad_hash[:fuel] = fuel doc_single

    ad_hash[:body_color_id] = body_color_id doc_single
    ad_hash[:internal_color_id] = internal_color_id doc_single


    ad_hash[:location]  = location doc_single
    loc = extract_lat_lng(ad_hash[:location])
    ad_hash[:latitude]  = loc[:latitude]
    ad_hash[:longitude] = loc[:longitude]

    ad_hash[:year] = year(doc_single)
    ad_hash[:year_format] = year_format(doc_single)

    ad_hash[:make_id] = make(doc_single)
    ad_hash[:car_model_id] = car_model(doc_single, ad_hash[:make_id])

    ad_hash[:usage_type] = usage_type(doc_single, ad_hash[:price], ad_hash[:millage])

    ad_hash
  end

  def make doc_single
    if self.name == "bama"
      feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
      make_name = feature.text.split("،")[1].strip
    elsif self.name == "takhtegaz"
      make_name = doc_single.css('#bread_crumbs>li:nth-child(3)').text.strip
    end
    make = Make.find_or_create_by(name: make_name)
    make.id
  end

  def car_model(doc_single, make_id)
    make = Make.find make_id
    if self.name == "bama"
      feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
      car_model_name = feature.text.split("،")[2].strip
    elsif self.name == "takhtegaz"
      car_model_name = doc_single.css('.statistics>li:nth-child(1)>a').text
      car_model_name = car_model_name.gsub make.name, "" 
      car_model_name = car_model_name.strip
    end
    car_model = CarModel.find_by(name: car_model_name)
    unless car_model
      car_model = CarModel.create(name: car_model_name, make_id: make.id)
    end
    car_model.id
  end

  def extract_lat_lng location
    l = {}
    myloc = Location.where(name: location).first
    if myloc && myloc.latitude
      lat = myloc.latitude
      lng = myloc.longitude
    else
      loc = Geocoder.search(location)[0]
      lat = loc.try(:latitude)
      lng = loc.try(:longitude)
      Location.create(name: location, latitude: lat, longitude: lng)  if lng
    end
    l[:latitude]  = lat
    l[:longitude] = lng
    l
  end

  def tel doc_single
    if self.name == "bama"
      doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblCellphoneNumber').text
    elsif self.name == "takhtegaz"
      doc_single.css('#df_field_mobile img').first['src']
    end
  end

  def thumb_img doc_single
    if self.name == "bama"
      doc_single.css('#Thumb1').first["src"].gsub "../..", "http://www.bama.ir" if  doc_single.css('#Thumb1').first
    elsif self.name == "takhtegaz"
      doc_single.css('.slider li div img').first["src"] if  doc_single.css('.slider li div img').first
    end
  end

  def price doc_single
    if self.name == "bama"
      price = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblPrice')
      (price.text.gsub! ",", "").to_i
    elsif self.name == "takhtegaz"
      price = doc_single.css('#df_field_price .value')
      (price.text.gsub! ",", "").to_i
    end
  end

  def millage doc_single
    if self.name == "bama"
      millage = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblMilage')
      millage = millage.text.to_i
    elsif self.name == "takhtegaz"
      millage = doc_single.css('#df_field_mileage .value')
      millage = (millage.text.gsub! ",", "").to_i
    end
    millage<5000000 ? millage : nil
  end

  def details doc_single
    if self.name == "bama"
      doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblDescr').text
    elsif self.name == "takhtegaz"
      doc_single.css('#df_field_description_add .value').text.strip
    end
  end

  def girbox doc_single
    if self.name == "bama"
      girbox_type = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblGearboxType')
      GIRBOX_ARR.index girbox_type.text
    elsif self.name == "takhtegaz"
      girbox_type = doc_single.css('#df_field_transmission .value').text.strip
      (girbox_type == "گیربکس دستی")  ? 0 : 1
    end
  end

  def fuel doc_single
    if self.name == "bama"
      fuel = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblFuelType').text.strip
      FUEL_ARR.index fuel
    elsif self.name == "takhtegaz"
      fuel = doc_single.css('#df_field_fuel .value').text.strip
      FUEL_ARR.index fuel
    end
  end

  def body_color_id doc_single
    if self.name == "bama"
      body_color = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblExColor')
    elsif self.name == "takhtegaz"
      body_color = doc_single.css('#df_field_ext_color .value')
    end
    color = Color.find_or_create_by(name: body_color.text.strip)
    color.id
  end

  def internal_color_id doc_single
    if self.name == "bama"
      internal_color = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblInColor')
    elsif self.name == "takhtegaz"
      internal_color = doc_single.css('#df_field_int_color .value')
    end
    color = Color.find_or_create_by(name: internal_color.text.strip)
    color.id
  end

  def location doc_single
    if self.name == "bama"
      doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblProvinceName').text.strip
    elsif self.name == "takhtegaz"
      doc_single.css('#df_field_province .value').text.strip
    end
  end

  def year doc_single
    if self.name == "bama"
      feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
      year = feature.text.split("،")[0].to_i
    elsif self.name == "takhtegaz"
      if doc_single.css('#df_field_built .value').present?
        year = doc_single.css('#df_field_built .value').text.to_i  
      elsif doc_single.css('#df_field_years_persian .value').present?
        year = doc_single.css('#df_field_years_persian .value').text.to_i
      end
    end

    if year
      if year < 1900
        JalaliDate.new(year,10,15).to_g
      elsif year
        ("#{year}-1-1").to_date
      end
    end

  end

  def year_format doc_single
    if self.name == "bama"
      feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
      year = feature.text.split("،")[0].to_i
      (year < 1900) ? true : false
    elsif self.name == "takhtegaz"
      doc_single.css('#df_field_built .value').present? ? false : true # shamsi = true
    end
  end

  def usage_type doc_single, price, millage
    if self.name == "bama"
      if price == 0 && millage == 0
        2
      elsif millage == 0
        1
      else
        0
      end   
    elsif self.name == "takhtegaz"
      usage_type = doc_single.css('#df_field_condition .value').text.strip
      usage_type == "کارکرده" ? 0 : 1
    end
  end

  def termination_check doc_single
    if self.name == "bama"
      date = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblDate').text
      date == "امروز" ? false : true
    elsif self.name == "takhtegaz"
      date = ( doc_single.css( '.statistics li:nth-child(3)' ).text ).gsub "ارسال شده: ",""
      date = date.split("/")
      date = JalaliDate.new(date[0].to_i, date[1].to_i, date[2].to_i)
      date == JalaliDate.new( Date.today) ? false : true
    end
  end

  def index_page_row(doc)
    if self.name == "bama"
      doc.css('.center a.grid')      
    elsif self.name == "takhtegaz"
      doc.css('.list .item .fields a')      
    else
      
    end
  end

end
