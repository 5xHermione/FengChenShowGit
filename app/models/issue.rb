class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository
end
