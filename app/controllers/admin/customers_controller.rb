class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def comics
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
  end

  #ブックマーク一覧
  def bookmark
    @customer = Customer.find(params[:id])
    bookmarks = Bookmark.where(customer_id: @customer.id).pluck(:comic_id)
    @bookmark_comics = Comic.find(bookmarks)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :email, :is_deleted)
  end

end
