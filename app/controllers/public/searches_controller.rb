class Public::SearchesController < ApplicationController

  def search
    @comics = Comic.published.looks(params[:search], params[:word])
  end

end
