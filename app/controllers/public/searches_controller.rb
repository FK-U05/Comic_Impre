class Public::SearchesController < ApplicationController

  def search
    @comics = Comic.looks(params[:search], params[:word])
  end

end
