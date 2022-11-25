class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_top_path, notice: "ジャンル名を保存しました。"
    else
      redirect_to admin_top_path, notice: "ジャンル名を入力してください。"
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_top_path, notice: "ジャンル名を編集 / 保存しました。"
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_top_path, notice: "ジャンル名を削除しました。"
  end

  def genre_params
    params.require(:genre).permit(:genre_name)
  end

end
