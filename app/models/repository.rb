class Repository < ApplicationRecord
  validates :title, presence: true
end
