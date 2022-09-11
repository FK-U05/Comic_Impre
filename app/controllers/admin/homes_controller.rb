class Admin::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @tags = Tag.all
  end

end
