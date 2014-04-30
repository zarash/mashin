class SearchesController < ApplicationController
  def index
  	if params[:id]
  		@search = Search.find(params[:id])
  	else
  		@search = Search.new
  	end  	
  	@ads = @search.ads.page(params[:page]).per_page(10)
  end

  def create
  	@search = Search.new(search_params)
  	@search.year_from = correct_date(search_params[:year_from]) if search_params[:year_from].present?
  	@search.year_to   = correct_date( search_params[:year_to])  if search_params[:year_to].present?
  	@search.save
  	redirect_to @search
  end

  def show
  	@search = Search.find(params[:id])
  	@ads = @search.ads #.page(params[:page]).per_page(10)
  end

private

	def search_params
    params.require(:search).permit(:year_from, :year_to, 
                                   :price_from, :price_to, 
                                   :millage_from, :millage_to,
                                   :make_id, :car_model_id,
                                   :location, :radius,
                                   :order
                                   )
  end

  def correct_date year
  	if search_params[:date_format] = false
	  	("1/1/"+year).to_date if year.present?
  	else
		  JalaliDate.new(year.to_i,1,1).to_g 
  	end
  end
end 
