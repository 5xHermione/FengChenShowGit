class Repository < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :issues
end
