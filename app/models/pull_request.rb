class PullRequest < ApplicationRecord
  belongs_to :repository
  validates :name, presence: true
end
