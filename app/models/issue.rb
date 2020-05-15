class Issue < ApplicationRecord
  validates :name, presence: true
  belongs_to :repository

  enum status: {close: 'Close' , publish: 'Reopen',}

  def toggle_status
    self.status = self.publish? ? :close : :publish
  end

  # soft_delete
  # scope :not_deleted, -> { where(soft_deleted: false) }
  # scope :deleted, -> { where(soft_deleted: true) }
end
