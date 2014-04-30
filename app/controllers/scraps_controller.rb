class ScrapsController < ApplicationController
  def show

  end

  def scrap
    scrap = Scrap.new
    scrap.url = "http://www.bama.ir/car/mix/sort=1;page="
    scrap.save

    scrap.sweep

    redirect_to root_path
  end

end
