class Tag < ApplicationRecord

  has_many :comic_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :comics, through: :comic_tags

  def self.looks(searches, words)
    if searches == "perfect_match"
      @Tag = Tag.where("tag_name LIKE ?", "#{words}")
    else
      @tag = Tag.where("tag_name LIKE ?", "%#{words}%")
    end
  end

end
