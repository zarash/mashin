desc "Fetch product prices"
task :bama => :environment do
  require 'nokogiri'
  require 'open-uri'
 
  scrap = Scrap.new
  scrap.url = "http://www.bama.ir/car/mix/sort=1;page="
  scrap.save
  scrap.sweep
end