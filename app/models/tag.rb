class Tag < ApplicationRecord

  has_many :comic_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :comics, through: :comic_tags

  validates :tag_name, presence: true

end
