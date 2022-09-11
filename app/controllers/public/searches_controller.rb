class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "Comic"
      @comics = Comic.looks(params[:search], params[:word])
    elsif @range == "Genre"
      @genres = Genre.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
  end

end
