desc "Fetch product prices"
task :scrap => :environment do
  require 'nokogiri'
  require 'open-uri'
 
  scrap = Scrap.new
  scrap.url = "http://obscure-woodland-9401.herokuapp.com/ads"
  scrap.save
  scrap.sweep
end