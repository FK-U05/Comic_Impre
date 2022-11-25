class Genre < ApplicationRecord

  has_many :comic_genres, dependent: :destroy, foreign_key: 'genre_id'
  has_many :comics, through: :comic_genres

  validates :genre_name, presence: true

end
