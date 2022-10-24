class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!

  def create
    @comic = Comic.find(params[:comic_id])
    bookmark = current_customer.bookmarks.new(comic_id: @comic.id)
    bookmark.save
    redirect_to comic_path(@comic), notice: "ブックマークしました！"
  end

  def destroy
    @comic = Comic.find(params[:comic_id])
    bookmark = current_customer.bookmarks.find_by(comic_id: @comic.id)
    bookmark.destroy
    redirect_to comic_path(@comic), notice: "ブックマークを外しました。"
  end
end
