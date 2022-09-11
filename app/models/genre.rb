class Genre < ApplicationRecord

  has_many :comic_genres, dependent: :destroy, foreign_key: 'genre_id'
  has_many :comics, through: :comic_genres

 def self.looks(searches, words)
    if searches == "perfect_match"
      @genre = Genre.where("genre_name LIKE ?", "#{words}")
    else
      @genre = Genre.where("genre_name LIKE ?", "%#{words}%")
    end
 end

end
