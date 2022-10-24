class Public::ComicCommentsController < ApplicationController
  before_action :authenticate_customer!,except:[:index]

  def index
    @comic = Comic.find(params[:comic_id])
    @comic_comment = ComicComment.all
  end

  def create
    @comic = Comic.find(params[:comic_id])
    @comment = current_customer.comic_comments.new(comic_comment_params)
    @comment.comic_id = @comic.id
    if @comment.save
       redirect_to comic_comic_comments_path(@comic), notice: "コメントを送信しました！"
    else
       redirect_to comic_path(@comic), alert: "コメント内容を入力してください"
    end
  end

  def destroy
    @comic = Comic.find(params[:comic_id])
    ComicComment.find(params[:id]).destroy
    redirect_to comic_comic_comments_path(@comic), notice: "コメントを削除しました。"
  end

private
  def comic_comment_params
    params.require(:comic_comment).permit(:comic_id, :comment)
  end
end
