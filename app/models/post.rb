class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true
  
  #いいね機能
  def favorited_by?(user)
    return false if user.nil? # ユーザーがnilの場合はfalseを返す
    favorites.exists?(user_id: user.id)
  end
  
  #POST検索機能
  def self.search_for(content, method)
    Post.where("title LIKE ? OR body LIKE ?", "%#{content}%", "%#{content}%")
  end
  
  #投稿画像設定
  has_one_attached :image
  def get_image #画像の添付があった場合のみ、画像を表示させる。画像添付がない場合、何も返さない。
    image if image.attached?
  end
  
end
