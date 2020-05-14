class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :repositories
  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "format does not match."}
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true,
                                   format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." }
  validates :slug, length: { in: 1..64 },
                          uniqueness: true,
                          format: { with: /\A[a-zA-Z0-9_]+\z/ } 
  def save_slug_with_name
    self.slug = self.name if save
  end
end
