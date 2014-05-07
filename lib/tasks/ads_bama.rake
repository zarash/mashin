desc "Fetch product prices"
task :bama => :environment do
  require 'nokogiri'
  require 'open-uri'
 
  scrap = Scrap.new
  scrap.url = "http://www.bama.ir/car/mix/sort=1;page=my_page_counter"
  scrap.save
  scrap.sweep
end