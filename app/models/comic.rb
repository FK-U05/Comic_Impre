class Comic < ApplicationRecord

  has_many :genres, dependent: :destroy
  has_many :tags, dependent: :destroy
  belongs_to :customer
  belongs_to :company

end
