class User < ApplicationRecord
  blacklists = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  
  has_many :repositories, dependent: :destroy
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
