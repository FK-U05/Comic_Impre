class Admin::ComicsController < ApplicationController

  def index
    @tag_list = Tag.all
    @genre_list = Genre.all
    if  params[:latest]
        @comics = Comic.latest.page(params[:page]).per(3)
    elsif params[:old]
        @comics = Comic.old.page(params[:page]).per(3)
    elsif params[:star_count]
        @comics = Comic.star_count.page(params[:page]).per(3)
    elsif params[:comic_comment]
        comics = Comic.comic_comment_count
        @comics = Kaminari.paginate_array(comics).page(params[:page]).per(3)
    elsif params[:bookmark_count]
        comics = Comic.bookmark_count
        @comics = Kaminari.paginate_array(comics).page(params[:page]).per(3)
    else
        @comics = Comic.all.order(created_at: :desc).page(params[:page]).per(3)
    end
  end

  def show
    @comic = Comic.find(params[:id])
    @customer = @comic.customer
    @comic_tags = @comic.tags
    @comic_genres = @comic.genres
  end

  def edit
    @comic = Comic.find(params[:id])
    @genre_list = @comic.genres.pluck(:genre_name).join(nil)
    @tag_list = @comic.tags.pluck(:tag_name).join(nil)
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
      redirect_to admin_comic_path(@comic)
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to admin_comics_path
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
    params.require(:comic).permit(:title, :body, :name, :company, :release_date, :star)
  end

end
