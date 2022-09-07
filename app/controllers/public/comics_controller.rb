class Public::ComicsController < ApplicationController

  def index
    @comics = Comic.all
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.customer_id = current_customer.id
    if @comic.save
    redirect_to public_comic_path(@comic)
    end
  end

  def check
    @comic = Comic.new(comic_params)
    @comic.customer_id = current_customer.id
  end

  def show
    @comic = Comic.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def comic_params
    params.require(:comic).permit(:company_id, :title, :body, :name, :release_date)
  end

end
