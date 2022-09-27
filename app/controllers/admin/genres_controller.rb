class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @genre = Genre.find(params[:id])
    @genre_list = @genres
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
