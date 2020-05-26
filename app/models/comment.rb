class Comment < ApplicationRecord
  #參考資料：https://ihower.tw/rails/activerecord-relationships.html#sec7
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :content, presence: true
end
