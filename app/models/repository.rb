class Repository < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :issues
  validate :check_unique_title
  validates :title, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." }
  
  before_save :save_slug_with_title

  extend FriendlyId
  friendly_id :title, use: :slugged


  def check_unique_title
    # blank? 檢查東西是不是沒有或是空值
    # present? 檢查東西是不是存在
    if user.repositories.find_by(title: title).present?
      errors.add(:title, ": This title already exitsts!")
    end
  end

  def save_slug_with_title
    self.slug = self.title if save
  end
end