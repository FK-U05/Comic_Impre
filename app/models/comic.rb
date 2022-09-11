class Comic < ApplicationRecord

  #ジャンルの中間テーブルとアソシエーション
  has_many :comic_genres, dependent: :destroy
  has_many :genres, through: :comic_genres

  #タグの中間テーブルとアソシエーション
  has_many :comic_tags, dependent: :destroy
  has_many :tags, through: :comic_tags

  has_many :comic_comments, dependent: :destroy
  belongs_to :customer

  #ジャンルリスト
  def genres_save(genre_list)
    if self.genres != nil
      comic_genres_records = ComicGenre.where(comic_id: self.id)
      comic_genres_records.destroy_all
    end

    genre_list.each do |genre|
      inspected_genre = Genre.where(genre_name: genre).first_or_create
      self.genres << inspected_genre
    end
  end

  #タグリスト
  def tags_save(tag_list)
    if self.tags != nil
      comic_tags_records = ComicTag.where(comic_id: self.id)
      comic_tags_records.destroy_all
    end

    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      self.tags << inspected_tag
    end
  end

#タイトルを検索
  def self.looks(searches, words)
    if searches == "perfect_match"
      @comic = Comic.where("title LIKE ?", "#{words}")
    else
      @comic = Comic.where("title LIKE ?", "%#{words}%")
    end
  end

end
