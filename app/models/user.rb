class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :name_kana, presence: true, format: { message: "はカタカナで入力してください", with: /\A[ァ-ヶー－]+\z/ }, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, format: { message: "を正しく入力してください", with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/i }
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  #フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  #フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  
  #フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  
  #指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  #指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  #指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end
  
  #ユーザー検索機能
  def self.search_for(content, method)
    User.where("name LIKE ? OR name_kana LIKE ? OR introduction LIKE ?", "%#{content}%", "%#{content}%", "%#{content}%")
  end
  
  #プロフィール画像設定
  has_one_attached :profile_image
  def get_profile_image(width, height)
    if profile_image.attached?
      # 画像がアップロードされている場合
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      # 画像がアップロードされていない場合、アセットパイプラインから画像を取得
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
  
  #ゲストログイン機能
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.name_kana = "ゲスト"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
end
