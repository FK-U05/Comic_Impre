class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
    @comic = Comic.order('id DESC').limit(1)
  end

  def edit
  end

  def update
  end

  #ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer   # ユーザーをログインさせる
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  #退会確認
  def quit
  end

  #退会処理
  def withdrawal
  end

private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end

end
