class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "Comic"
       @comics = Comic.looks(params[:search], params[:word])
    elsif @range == "Customer"
       @customers = Customer.looks(params[:search], params[:word])
    end
  end

end
