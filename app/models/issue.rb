class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable

  def toggle_status
    if self.status == "close"
      self.status = "open" 
    else
      self.status = "close"  
    end
  end
end

