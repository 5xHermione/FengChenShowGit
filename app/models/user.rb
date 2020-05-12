class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,  :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :repositories
  validates :name, presence: true, uniqueness: true
end
