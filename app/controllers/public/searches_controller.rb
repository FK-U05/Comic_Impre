class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @comics = Comic.looks(params[:search], params[:word])
  end

end
