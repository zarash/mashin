class ScrapsController < ApplicationController
  def index
    @scrap = Scrap.new
    # @scrap.name = "obscure-woodland-9401"
  end

  def scrap
    scrap = Scrap.new
    scrap.url = "http://obscure-woodland-9401.herokuapp.com/ads"
    scrap.save
    scrap.sweep
    redirect_to root_path    
  end

end