class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository

<<<<<<< HEAD
  def toggle_status

    if self.status == "Close"
      self.status = "Open" 
    else
      self.status = "Close"  
    end

=======
  enum status: {close: 'Close' , publish: 'Reopen',}

  def toggle_status
    self.status = self.publish? ? :close : :publish
>>>>>>> issue開關初階段完成&issue路經修改調整
  end

  # soft_delete
  # scope :not_deleted, -> { where(soft_deleted: false) }
  # scope :deleted, -> { where(soft_deleted: true) }
end
