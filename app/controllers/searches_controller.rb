class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @search.save
    redirect_to search_path(@restaurant)
  end


  private

  def search_params
    params.require(:search).permit(:content)
  end

end
