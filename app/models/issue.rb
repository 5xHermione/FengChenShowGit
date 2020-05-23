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

end
