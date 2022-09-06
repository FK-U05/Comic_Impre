class Genre < ApplicationRecord

  has_many :comics, dependent: :destroy
end
