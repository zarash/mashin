class ScrapsController < ApplicationController
  def index
    @scrap = Scrap.new
    @scrap.name = "obscure-woodland-9401"
  end

  def scrap
    scrap = Scrap.new
    scrap.url = "http://obscure-woodland-9401.herokuapp.com/ads"
    scrap.save
    scrap.sweep
    redirect_to root_path    
  end

  def bama
    # scrap = Scrap.new
    # scrap.url = "http://www.bama.ir/car/mix/sort=1;page=my_page_counter"
    # scrap.name = "bama"
    # scrap.save

    # scrap.sweep

    # redirect_to root_path
  end

  def takhtegaz
    # scrap = Scrap.new
    # scrap.url = "http://www.takhtegaz.com/recently-added/autos/indexmy_page_counter.html"
    # scrap.name = "takhtegaz"
    # scrap.save

    # scrap.sweep

    # redirect_to root_path
  end

end