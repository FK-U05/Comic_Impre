class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
    @comic = Comic.order('id DESC').limit(1)
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

  #ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer   # ユーザーをログインさせる
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  #退会確認
  def quit
    @customer = current_customer
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
