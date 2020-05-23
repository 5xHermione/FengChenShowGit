class User < ApplicationRecord
  blacklists = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :repositories, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :followed_users, through: :active_relationships, source: :followed_users
  has_many :follower_users, through: :passive_relationships, source: :follower_users


  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "format does not match."},
                    presence: true, uniqueness: true
  validates :name, presence: true, 
                   uniqueness: true,
                   format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." },
                   exclusion: { in: blacklists, message: ": Please change another user name."}
end
