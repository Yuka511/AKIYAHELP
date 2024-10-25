class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :name_kana, presence: true, format: { message: "はカタカナで入力してください", with: /\A[ァ-ヶー－]+\z/ }, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, format: { message: "を正しく入力してください", with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/i }
  
  has_many :posts, dependent: :destroy
  
  #プロフィール画像設定
  has_one_attached :profile_image
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #ゲストログイン機能
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
end
