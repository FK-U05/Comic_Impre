class Public::ComicCommentsController < ApplicationController

  def index
    @comic = Comic.find(params[:comic_id])
    @comic_comment = ComicComment.all
  end

  def create
    @comic = Comic.find(params[:comic_id])
    @comment = current_customer.comic_comments.new(comic_comment_params)
    @comment.comic_id = @comic.id
    @comment.save
    redirect_to public_comic_comic_comments_path(@comic)
  end

  def destroy
    @comic = Comic.find(params[:comic_id])
    ComicComment.find(params[:id]).destroy
    redirect_to public_comic_comic_comments_path(@comic)
  end

private
  def comic_comment_params
    params.require(:comic_comment).permit(:comic_id, :comment)
  end
end
