class Public::ComicsController < ApplicationController
  def index
    if  params[:latest]
        @comics = Comic.latest.page(params[:page]).per(3)
    elsif params[:old]
        @comics = Comic.old.page(params[:page]).per(3)
    elsif params[:star_count]
        @comics = Comic.star_count.page(params[:page]).per(3)
    elsif params[:comic_comment]
        @comics = Comic.comic_comment_count.page(params[:page]).per(3)
    elsif params[:bookmark_count]
        @comics = Comic.bookmark_count.page(params[:page]).per(3)
    else
        @comics = Comic.all.order(created_at: :desc).page(params[:page]).per(3)
        @tag_list = Tag.all
        @genre_list = Genre.all
    end
  end

  def new
    @comic = Comic.new
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
    if params[:back] || !@comic.save #戻るボタンを押したときまたは、@comicが保存されなかったらnewアクションを実行
       render :new and return
    end
    redirect_to public_comics_path
  end

  def check
    @comic = current_customer.comics.new(comic_params)
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(nil)
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(nil)
    @comic.tags_save(tag_list)
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
       redirect_to public_comics_path
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
      redirect_to public_comic_path(@comic)
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to public_comics_path
  end

  #タグで絞り込んだ投稿一覧
  def tag_search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @comics = @tag.comics.all
  end

  #ジャンルで絞り込んだ投稿一覧
  def genre_search
    @genre_list = Genre.all
    @genre = Genre.find(params[:genre_id])
    @comics = @genre.comics.all
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :body, :name, :company, :release_date, :star, { genre_ids: []}, { tag_ids: []} )
  end

end
