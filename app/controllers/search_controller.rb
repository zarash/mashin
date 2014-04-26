class SearchController < ApplicationController
  def show
  	@search = Search.new(params[:search])
  	if params[:search].nil?
  		@ads = @search.new_ads.page(params[:page]).per_page(10)
  	else
  		@ads = @search.searched_ads.page(params[:page]).per_page(10) if @search.valid?
  	end
  end
end