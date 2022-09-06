class Tag < ApplicationRecord

  has_many :comics, dependent: :destroy

end
