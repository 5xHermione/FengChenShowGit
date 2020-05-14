class Repository < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :user,
                                                  message: ": This title already exitsts!" }
  belongs_to :user
  has_many :issues
  validates :title, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." }
end
