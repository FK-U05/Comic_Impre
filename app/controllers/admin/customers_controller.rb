class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を編集 / 保存しました。"
    else
       render "edit"
    end
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
    @bookmark_comics = Comic.order(created_at: :desc).page(params[:page]).per(3)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :email, :is_deleted)
  end

end
