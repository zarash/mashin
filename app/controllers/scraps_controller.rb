class ScrapsController < ApplicationController
  def show

  end

  def scrap
    scrap = Scrap.new
    scrap.url = "http://www.bama.ir/car/page="
    scrap.save

    scrap.sweep

    redirect_to action: "index"
  end

end
