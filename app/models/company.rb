class Company < ApplicationRecord
   has_many :comics, dependent: :destroy
end
