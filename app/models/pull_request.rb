class PullRequest < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  validates :name, presence: true,
                   length: {maximum: 100}
  has_many :comments, dependent: :destroy, as: :commentable
end
