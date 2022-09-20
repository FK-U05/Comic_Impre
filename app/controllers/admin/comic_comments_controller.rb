class Admin::ComicCommentsController < ApplicationController
 before_action :authenticate_admin!


 def index
  @comic = Comic.find(params[:comic_id])
  @comic_comment = ComicComment.all
 end

 def destroy
  @comic = Comic.find(params[:comic_id])
  ComicComment.find(params[:id]).destroy
  redirect_to admin_comic_comic_comments_path(@comic), notice: "コメントを削除しました。"
 end

end
