class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!


  def create
    @comic = Comic.find(params[:comic_id])
    bookmark = current_customer.bookmarks.new(comic_id: @comic.id)
    bookmark.save
    redirect_to public_comic_path(@comic)
  end

  def destroy
    @comic = Comic.find(params[:comic_id])
    bookmark = current_customer.bookmarks.find_by(comic_id: @comic.id)
    bookmark.destroy
    redirect_to public_comic_path(@comic)
  end
end
