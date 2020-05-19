class User < ApplicationRecord

  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :repositories, dependent: :destroy
  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "format does not match."}
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, 
                   uniqueness: true,
                   format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." },
                   exclusion: { in: Blacklist.pluck(:name), message: ": Please change another user name."}
  # validates_exclusion_of :name, in: Blacklist.select(:name), message: ": Please change another user name."
end
