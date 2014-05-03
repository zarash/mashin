class HomesController < ApplicationController
  def show
    @search = Search.new
  end
end
