class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_top_path, notice: "タグ名を保存しました。"
    else
      redirect_to admin_top_path, notice: "タグ名を入力してください。"
    end
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
