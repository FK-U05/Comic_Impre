class ComicComment < ApplicationRecord
  belongs_to :comic
  belongs_to :customer

  validates :comment, presence: true, length: { minimum: 1 }

end
