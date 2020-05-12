class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :repositories
  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "format does not match."}
  validates :name, presence: true, uniqueness: true,
                                   format: { with: /A[a-zA-Z0-9_]/, message: "only allows alphabets, numbers and underscore." }
end
