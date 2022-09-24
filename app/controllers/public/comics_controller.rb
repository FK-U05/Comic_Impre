class Public::ComicsController < ApplicationController
  before_action :authenticate_customer!, except:[:index, :show, :tag_search, :genre_search]

  def index
    @tag_list = Tag.all
    @genre_list = Genre.all
    if  params[:latest]
        @comics = Comic.where(status: :published).latest.page(params[:page]).per(3)
    elsif params[:old]
        @comics = Comic.where(status: :published).old.page(params[:page]).per(3)
    elsif params[:star_count]
        @comics = Comic.where(status: :published).star_count.page(params[:page]).per(3)
    elsif params[:comic_comment]
        comics = Comic.where(status: :published).comic_comment_count
        @comics = Kaminari.paginate_array(comics).page(params[:page]).per(3)
    elsif params[:bookmark_count]
        comics = Comic.where(status: :published).bookmark_count
        @comics = Kaminari.paginate_array(comics).page(params[:page]).per(3)
    else
        @comics = Comic.where(status: :published).order(created_at: :desc).page(params[:page]).per(3)
    end
  end

  def new
    if current_customer.email == 'guest@guest'
       redirect_to root_path, alert: "ゲストユーザーは投稿できません。会員新規登録をお願いします。"
    else
       @comic = Comic.new
    end
  end

  def create
    #ログインしているユーザーのIDがcomicテーブルに保存される
    @comic = current_customer.comics.new(comic_params)
    @comic.save
    #入力されたジャンル名をgenre_listに追加する
    #split(nil)で送信された値をスペースで区切って配列化する
    genre_list = params[:comic][:genre_names][0].split(nil)
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_names][0].split(nil)
    @comic.tags_save(tag_list)
    redirect_to public_comics_path, notice: "投稿 / 保存できました！"
    if params[:back] || !@comic.save #戻るボタンを押したときまたは、@comicが保存されなかったらnewアクションを実行
       render :new and return
    end
  end

  def check
    @comic = current_customer.comics.new(comic_params)
     #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(nil)
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(nil)
    @comic.tags_save(tag_list)
    if @comic.invalid? #必須項目に空のものがあれば入力画面に遷移
       flash.now[:alert] = "必要項目を入力してください"
       render :new
    end
  end

  #確認画面で戻るを選択
  def back
    @comic = Comic.new(comic_params)
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_names][0].split(nil)
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_names][0].split(nil)
    @comic.tags_save(tag_list)
    render :new
  end

  def show
    @comic = Comic.find(params[:id])
    @comic_tags = @comic.tags
    @comic_genres = @comic.genres
    @comic_comment = ComicComment.new
  end

  def edit
    @comic = Comic.find(params[:id])
    if @comic.customer.id != current_customer.id
       redirect_to public_comics_path, alert: "他のユーザーの投稿はできません。"
    end
    @genre_list = @comic.genres.pluck(:genre_names).join(nil)
    @tag_list = @comic.tags.pluck(:tag_names).join(nil)
  end

  def update
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
      #入力されたジャンル名をgenre_listに追加する
      #まずはからになっている配列を消す
      genre_ids = params[:comic][:genre_ids].reject(&:empty?)
      #予め選択されているジャンルを取り出す
      genre_names_check_box = Genre.find(genre_ids).pluck(:genre_name)
      #新たに作成したジャンル
      genre_names_txt = params[:comic][:genre_names].split(nil)
      #作成したジャンルと元からあるものを足す
      genre_list = genre_names_check_box + genre_names_txt
      @comic.genres_save(genre_list)
      tag_ids = params[:comic][:tag_ids].reject(&:empty?)
      tag_names_check_box = Tag.find(tag_ids).pluck(:tag_name)
      tag_names_txt = params[:comic][:tag_names].split(nil)
      tag_list = tag_names_check_box + tag_names_txt
      @comic.tags_save(tag_list)
      redirect_to public_comic_path(@comic), notice: "投稿を編集 / 保存しました。"
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to public_comics_path, notice: "投稿を削除しました。"
  end

  #タグで絞り込んだ投稿一覧
  def tag_search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @comics = @tag.comics.where(status: :published).page(params[:page]).per(3)
  end

  #ジャンルで絞り込んだ投稿一覧
  def genre_search
    @genre_list = Genre.all
    @genre = Genre.find(params[:genre_id])
    @comics = @genre.comics.where(status: :published).page(params[:page]).per(3)
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :body, :name, :company, :release_date, :star, :status, { genre_ids: []}, { tag_ids: []} )
  end

end
