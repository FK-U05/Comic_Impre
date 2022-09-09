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
    if params[:back] || !@comic.save #戻るボタンを押したときまたは、@comicが保存されなかったらnewアクションを実行
      render :new and return
    end
    redirect_to public_comics_path
  end

  def check
    @comic = Comic.new(comic_params)
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(",")
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(",")
    @comic.tags_save(tag_list)
  end

  def show
    @comic = Comic.find(params[:id])
    @comic_comment = ComicComment.new
  end

  def edit
    @comic = Comic.find(params[:id])
    if @comic.customer.id != current_customer.id
    redirect_to public_comics_path
    end
    @genre_list = @comic.genres.pluck(:genre_name).join(',')
    @tag_list = @comic.tags.pluck(:tag_name).join(',')
  end

  def update
    @comic = Comic.find(params[:id])
    #入力されたジャンル名をgenre_listに追加する
    genre_list = params[:comic][:genre_name].split(",")
    @comic.genres_save(genre_list)
    #入力されたタグ名をtag_listに追加する
    tag_list = params[:comic][:tag_name].split(",")
    @comic.tags_save(tag_list)
    if @comic.update(comic_params)
      redirect_to public_comic_path(@comic)
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to public_comics_path
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :body, :name, :company, :release_date)
  end

end
