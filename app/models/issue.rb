class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository

  def toggle_status

    if self.status == "close"
      self.status = "open" 
    else
      self.status = "close"  
    end

  end
  
  # soft_delete
  # scope :not_deleted, -> { where(soft_deleted: false) }
  # scope :deleted, -> { where(soft_deleted: true) }
end
