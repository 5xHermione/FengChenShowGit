class User < ApplicationRecord
  blacklists = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
  devise :database_authenticatable, :recoverable, :rememberable, :registerable, :omniauthable, omniauth_providers: %i[github]

  before_create :create_relationship

  has_many :sshkeys
  has_many :pull_requests, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :repositories, dependent: :destroy
  has_many :commments, dependent: :destroy
  # 相關資料：https://rails.ruby.tw/association_basics.html，2-10 自連接部分
  has_many :active_relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :following_users, through: :active_relationships, source: :followed_user
  has_many :followers, through: :passive_relationships, source: :follower_user
  
  has_many :likes
  has_many :liked_repositories, through: :likes, source: :repository, class_name: "Repository"

  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "format does not match."},
                    presence: true, uniqueness: true
  validates :name, presence: true, 
                   uniqueness: true,
                   format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." },
                   exclusion: { in: blacklists, message: ": Please change another user name."},
                   length: {maximum: 32}

  mount_uploader :image, ImageUploader

  def create_relationship
    followed_user = User.find_by(email: "showgit@mail.com")
    if followed_user.present?
      relationship = self.active_relationships.new(followed_id: followed_user.id)
      relationship.save
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| # 在資料庫找不到使用者的話就創一個新的使用者
      user.provider = auth.provider # 登入資訊1
      user.uid = auth.uid           # 登入資訊2
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end
end
