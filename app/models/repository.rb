class Repository < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :issues
  validate :check_unique_title

  def check_unique_title
    # blank? 檢查東西是不是沒有或是空值
    # present? 檢查東西是不是存在
    if user.repositories.find_by(title: title).present?
      errors.add(:title, "can't be exists!")
    end
  end
end
