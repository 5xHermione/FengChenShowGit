class PullRequest < ApplicationRecord
  belongs_to :repository
  validates :name, presence: true
  has_many :comments, dependent: :destroy, as: :commentable
end
