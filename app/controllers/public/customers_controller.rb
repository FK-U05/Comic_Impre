class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
    @last_comic = Comic.where(customer_id: @customer).last
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
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer)
    else
      render "edit"
    end
  end

  def bookmark
    @customer = Customer.find(params[:id])
    bookmarks = Bookmark.where(customer_id: @customer.id).pluck(:comic_id)
    @bookmark_comics = Comic.find(bookmarks)
  end

  #ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer   # ユーザーをログインさせる
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  #退会確認
  def quit
    if current_customer.email == 'guest@guest'
    redirect_to root_path, alert: "ゲストユーザーは削除できません。"
    else
    @customer = current_customer
    end
  end

  #退会処理
  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :email)
  end

end
