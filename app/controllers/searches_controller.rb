class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def show
    @search = Search.find(params[:id])
    @url = @search.seloger_url
    @parsed_content = @search.seloger_xml_parseur
  end

  def new
    @search = Search.new
    @communes = communes
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to search_path(@search)
    else
      render :new
    end
  end


  private

  def search_params
    params.require(:search).permit(:goal, :old_new_type, :house_type, :location, :min_budget, :max_budget,
      :min_living_space, :max_living_space, :min_land_area, :max_land_area, :rooms, :bedrooms)
  end

  def communes
    require 'csv'
    filepath = 'app/controllers/communes.csv'
    communes = []
    CSV.foreach(filepath) do |row|
      communes << row
    end
    return communes
  end
end
