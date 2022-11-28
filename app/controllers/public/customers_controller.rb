class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!,except:[:show, :comics, :bookmark, :guest_sign_in]

  def show
    @customer = Customer.find(params[:id])
    @comic = Comic.find(params[:id])
    @comics = @customer.comics
    @last_comic = Comic.published.where(customer_id: @customer).last
  end

  def edit
    @customer = Customer.find(params[:id])
    if current_customer.email == 'guest@guest'
       redirect_to root_path, alert: "ゲストユーザーは会員情報を編集できません。"
    elsif @customer.id != current_customer.id
       redirect_to root_path, alert: "自分以外のユーザーの会員情報は編集できません。"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to customer_path(@customer), notice: "会員情報を編集 / 保存しました。"
    else
       flash.now[:alert] = "ユーザー名とメールアドレスを入力してください。"
       render :edit
    end
  end

  #投稿一覧
  def comics
    @customer = Customer.find(params[:id])
    if  params[:latest]
        @comics = @customer.comics.where(status: :published).latest.page(params[:page]).per(3)
    elsif params[:old]
        @comics = @customer.comics.where(status: :published).old.page(params[:page]).per(3)
    elsif params[:star_count]
        @comics = @customer.comics.where(status: :published).star_count.page(params[:page]).per(3)
    elsif params[:comic_comment]
        @comics = @customer.comics.where(status: :published).comic_comment_count.page(params[:page]).per(3)
    elsif params[:bookmark_count]
        @comics = @customer.comics.where(status: :published).bookmark_count.page(params[:page]).per(3)
    else
        @comics = @customer.comics.where(status: :published).order(created_at: :desc).page(params[:page]).per(3)
    end
  end

  #ネタバレ無しで絞り込む
  def no_spoiler
    @customer = Customer.find(params[:id])
    if  params[:latest]
        @no_spoiler = @customer.comics.where(spoiler_status: :true, status: :published).latest.page(params[:page]).per(3)
    elsif params[:old]
        @no_spoiler = @customer.comics.where(spoiler_status: :true, status: :published).old.page(params[:page]).per(3)
    elsif params[:star_count]
        @no_spoiler = @customer.comics.where(spoiler_status: :true, status: :published).star_count.page(params[:page]).per(3)
    elsif params[:comic_comment]
        @no_spoiler = @customer.comics.where(spoiler_status: :true, status: :published).comic_comment_count.page(params[:page]).per(3)
    elsif params[:bookmark_count]
        @no_spoiler = @customer.comics.where(spoiler_status: :true, status: :published).bookmark_count.page(params[:page]).per(3)
    else
        @no_spoiler = @customer.comics.where(spoiler_status: :true, status: :published).order(created_at: :desc).page(params[:page]).per(3)
    end
  end

  #ネタバレ有りで絞り込む
  def spoiler
    @customer = Customer.find(params[:id])
    if  params[:latest]
        @spoiler = @customer.comics.where(spoiler_status: :false, status: :published).latest.page(params[:page]).per(3)
    elsif params[:old]
        @spoiler = @customer.comics.where(spoiler_status: :false, status: :published).old.page(params[:page]).per(3)
    elsif params[:star_count]
        @spoiler = @customer.comics.where(spoiler_status: :false, status: :published).star_count.page(params[:page]).per(3)
    elsif params[:comic_comment]
        @spoiler = @customer.comics.where(spoiler_status: :false, status: :published).comic_comment_count.page(params[:page]).per(3)
    elsif params[:bookmark_count]
        @spoiler = @customer.comics.where(spoiler_status: :false, status: :published).bookmark_count.page(params[:page]).per(3)
    else
        @spoiler = @customer.comics.where(spoiler_status: :false, status: :published).order(created_at: :desc).page(params[:page]).per(3)
    end
  end

  #下書き一覧
  def draft
    @customer = Customer.find(params[:id])
    if @customer.id != current_customer.id
       redirect_to root_path, alert: "自分以外のユーザーの下書き一覧は表示できません。"
    elsif current_customer.email == 'guest@guest'
       redirect_to root_path, alert: "ゲストユーザーは投稿できません。会員新規登録をお願いします。"
    else
       @comics = @customer.comics.where(status: :draft).order('created_at DESC').page(params[:page]).per(3)
    end
  end

  #ブックマーク一覧
  def bookmark
    @customer = Customer.find(params[:id])
    bookmarks = Bookmark.where(customer_id: @customer.id).pluck(:comic_id)
    @bookmark_comics = Comic.find(bookmarks)
    @bookmark_comics = Kaminari.paginate_array(@bookmark_comics).page(params[:page]).per(3)
  end

  #ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer   # ユーザーをログインさせる
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  #退会確認
  def quit
    if current_customer.email == 'guest@guest'
       redirect_to root_path, alert: "ゲストユーザーは退会できません。"
    else
       @customer = current_customer
    end
  end

  #退会処理
  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会しました。"
  end

private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :email)
  end

end