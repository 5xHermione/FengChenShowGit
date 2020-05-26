class User < ApplicationRecord
  blacklists = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  
  has_many :sshkeys
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
                   exclusion: { in: blacklists, message: ": Please change another user name."}

  mount_uploader :image, ImageUploader

end
