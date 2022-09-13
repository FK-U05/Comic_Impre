class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :comics, dependent: :destroy
  has_many :comic_comments, dependent: :destroy

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fit: [width, height]).processed
  end

#ゲストログイン時のcustomer情報
  def self.guest
    find_or_create_by!(email: 'guest@guest') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
      customer.name = 'ゲスト'
    end
  end

  #検索
  def self.looks(searches, words)
    if searches == "perfect_match"
      @customer = Customer.where("name LIKE ?", "#{words}")
    else
      @customer = Customer.where("name LIKE ?", "%#{words}%")
    end
  end

end
