class Admin::ComicsController < ApplicationController

  def index
    @comics = Comic.all
  end

  def show
    @comic = Comic.find(params[:id])
    @customer = @comic.customer
    @comic_tags = @comic.tags
    @comic_genres = @comic.genres
  end

  def comics
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
  end

  def edit
    @comic = Comic.find(params[:id])
    @genre_list = @comic.genres.pluck(:genre_name).join(nil)
    @tag_list = @comic.tags.pluck(:tag_name).join(nil)
  end

  def update
    @comic = Comic.find(params[:id])
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(nil)
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(nil)
    @comic.tags_save(tag_list)
    if @comic.update(comic_params)
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
