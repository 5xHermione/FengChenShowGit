class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository

  enum status: {publish: 'publish', close: 'close'}

  def toggle_status
    # if self.status == "Close"
    #   self.status = "Reopen" 
    # else
    #   self.status = "Close"  
    # end
    self.status = self.publish? ? :close : :publish
  end
  
  # soft_delete
  # scope :not_deleted, -> { where(soft_deleted: false) }
  # scope :deleted, -> { where(soft_deleted: true) }
end
