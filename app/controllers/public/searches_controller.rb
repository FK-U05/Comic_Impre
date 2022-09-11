class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "Comic"
      @comics = Comic.looks(params[:search], params[:word])
    elsif @range == "Genre"
      @genres = Genre.looks(params[:search], params[:word])
      @comics = @genre.comics.all
    else
      @tags = Tag.looks(params[:search], params[:word])
      @comics = @tag.comics.all
    end
  end

end
