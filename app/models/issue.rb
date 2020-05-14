class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository
  
  # def status_name
  #   status ? "Yes" : "No"
  # end

  def toggle_status
    if status == "Close"
      status = "Reopen" 
    else
      status == "Reopen"
      status = "Close"  
    end
  end
  
  # soft_delete
  # scope :not_deleted, -> { where(soft_deleted: false) }
  # scope :deleted, -> { where(soft_deleted: true) }
end
