class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  def scrap
    girbox_arr = ["دنده ای", "اتوماتیک"]
    fuel_arr = ["بنزین", "دوگانه سوز", "هایبرید", "دیزل"]
    
    colors = [ "آبي",    "قرمز",   "سبز",    "نارنجي",   "سفيد",   "مشکي",   "آلبالوئی",   "اخرائی",   "اطلسی",    "بادمجانی",   "بژ",   "بنفش",   "پوست پیازی",   "خاکستری",    "خاکی",   "زرد",    "زرشکی",    "سربی",   "سرمه ای",    "صورتی",    "طلائی",    "عدسی",   "عنابی",    "قهوه ای",    "کرم",    "مسی",    "نقرآبی",   "نقره ای",    "نوک مدادی",    "یشمی",   "مارون",    "طوسی",   "زیتونی",   "شتری",   "برنز",   "دلفینی",   "گیلاسی",   "یاسی"]

    url = "http://www.bama.ir/car/page=1"
    doc = Nokogiri::HTML(open(url))

    doc.css('.center a.grid').each do |tag|

      url_single = tag["href"]

      doc_single = Nokogiri::HTML(open(url_single))

      tel = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblCellphoneNumber').text

      price = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblPrice')
      price = (price.text.gsub! ",", "").to_i

      millage = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblMilage')
      millage = millage.text.to_i

      details = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblDescr').text

      girbox_type = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblGearboxType')
      girbox = girbox_arr.index girbox_type.text

      fuel = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblFuelType')
      fuel = fuel_arr.index fuel.text

      body_color_id = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblExColor')
      body_color_id = colors.index body_color_id.text
      internal_color_id = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblInColor')
      internal_color_id = colors.index internal_color_id.text



      feature = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblBrandModelYear')
      year = feature.text.split("،")[0].to_i
      if year < 1900
        year = JalaliDate.new(year,10,15).to_g
      else
        year = ("#{year}-1-1").to_date
      end
      # carmodel = feature.text.split("،")[1]
      # brand = feature.text.split("،")[2]

      if price == 0 && millage == 0
        usage_type = 2
      elsif millage == 0
        usage_type = 1
      else
        usage_type = 0
      end

      Ad.create(ad_tel: tel, 
                price: price, 
                year: year, 
                details: details, 
                girbox: girbox, 
                millage: millage,
                origin_url: url_single,
                fuel: fuel,
                usage_type: usage_type,
                body_color_id: body_color_id,
                internal_color_id: internal_color_id,
                expration: (DateTime.now + 30.days)
              )
    end
    redirect_to action: "index"
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ad }
      else
        format.html { render action: 'new' }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:user_id, :carmodel_id, :body_color_id, :internal_color_id, :year, :price, :millage, :fuel, :girbox,  :expration, :active, :details)
    end
end
