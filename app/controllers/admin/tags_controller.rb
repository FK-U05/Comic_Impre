class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    redirect_to admin_top_path, notice: "タグ名を編集 / 保存しました。"
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_top_path, notice: "タグ名を削除しました。"
  end

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
