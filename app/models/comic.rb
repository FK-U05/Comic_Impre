class Comic < ApplicationRecord

  #ジャンルの中間テーブルとアソシエーション
  has_many :comic_genres, dependent: :destroy
  has_many :genres, through: :comic_genres

  #タグの中間テーブルとアソシエーション
  has_many :comic_tags, dependent: :destroy
  has_many :tags, through: :comic_tags

  has_many :comic_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  belongs_to :customer

  validates :company, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 1 }
  validates :name, presence: true
  validates :release_date, presence: true

  #下書き保存(１）か公開か（０）か
  enum status: {draft: 1,published: 0}

  #並び替え
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  scope :comic_comment_count, -> { left_joins(:comic_comments).group(:id).order("count(comic_comments.comic_id) desc")}
  scope :bookmark_count, -> { left_joins(:bookmarks).group(:id).order("count(bookmarks.comic_id) desc")}

  #ブックマーク
  def bookmarked_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end

  #ジャンルリスト
  def genres_save(sent_genres)
    #現在存在するジャンルの取得
    current_genres = self.genres.pluck(:genre_name) unless self.genres.nil?
    #古いジャンルの取得
    old_genres = current_genres - sent_genres
    #新しいジャンルの取得
    new_genres = sent_genres - current_genres
    #古いジャンルの削除
    old_genres.each do |old|
      self.genres.delete Genre.find_by(genre_name: old)
    end
    #新しいジャンルの保存
    new_genres.each do |new|
      new_genre = Genre.find_or_create_by(genre_name: new)
      self.genres << new_genre
    end
  end

  #タグリスト
  def tags_save(sent_tags)
    #現在存在するタグの取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    #古いタグの取得
    old_tags = current_tags - sent_tags
    #新しいタグの取得
    new_tags = sent_tags - current_tags
    #古いタグの削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    #新しいタグの保存
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tag
    end
  end

  #検索
  def self.looks(searches, words)
    #重複を防ぐuniq
    if searches == "perfect_match"
       @comic = Comic.joins(:tags, :genres)
                     .where(["title LIKE(?) OR company LIKE(?) OR name LIKE(?) OR tag_name LIKE(?) OR genre_name LIKE(?)",\
                     "#{words}", "#{words}", "#{words}", "#{words}", "#{words}"]).uniq
    else
       @comic = Comic.joins(:tags, :genres)
                     .where(["title LIKE(?) OR company LIKE(?) OR name LIKE(? ) OR tag_name LiKE(?) OR genre_name LIKE(?)",\
                     "%#{words}%", "%#{words}%", "%#{words}%", "%#{words}%", "%#{words}%"]).uniq
    end
  end

end
