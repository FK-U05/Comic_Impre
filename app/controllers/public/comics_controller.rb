class Public::ComicsController < ApplicationController

  def index
    @comics = Comic.all
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.customer_id = current_customer.id
    @comic.save
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(",")
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(",")
    @comic.tags_save(tag_list)
    redirect_to public_comics_path
  end

  def check
    @comic = Comic.new(comic_params)
    @comic.customer_id = current_customer.id
    @comic.save
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(",")
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(",")
    @comic.tags_save(tag_list)
  end

  def show
    @comic = Comic.find(params[:id])

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :body, :name, :company, :release_date)
  end

end
