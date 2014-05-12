class ScrapsController < ApplicationController
  def index
    system "rake scrap --trace &"
    redirect_to root_path    
  end

end