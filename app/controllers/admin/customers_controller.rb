class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page]).per(3)
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
  end

   #下書き一覧
  def draft
    @customer = Customer.find(params[:id])
    @comics = @customer.comics.where(status: :draft).order('created_at DESC').page(params[:page]).per(3)
  end

  #投稿一覧
  def comics
    @customer = Customer.find(params[:id])
    @comics = @customer.comics.order(created_at: :desc).page(params[:page]).per(3)
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
