desc "Fetch product prices"
task :bama => :environment do
  require 'nokogiri'
  require 'open-uri'
  
  url = "http://www.bama.ir/car/page=1"
	doc = Nokogiri::HTML(open(url))

  # Product.find_all_by_price(nil).each do |product|
    # url = "http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=#{CGI.escape(product.name)}&Find.x=0&Find.y=0&Find=Find"
#     title = doc.at_css(".grid span").text #[/[0-9\.]+/]
# puts title
    # Product.create(details: title)
    # product.update_attribute(:price, price)
  # end

  doc.css('a.grid').each do |tag|
		url_single = tag["href"]
		doc_single = Nokogiri::HTML(open(url_single))
		tel = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblCellphoneNumber')
		price = doc_single.css('#ctl00_cphMain_SelectedAdInfo1_lblPrice')

		# puts tel.text
		Ad.create(ad_tel: tel.text, price: price)
	end
end