class Repository < ApplicationRecord
  blacklists = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
  validates :title, presence: true, uniqueness: { scope: :user,
                                                  message: ": This title already exitsts!" }
  belongs_to :user
  has_many :issues, dependent: :destroy
  validates :title, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows alphabets, numbers and underscore." }

  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_exclusion_of :title, in: blacklists, message: ": Please change another repository title."
  before_save :convert_slug_to_same_title

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  private

  def convert_slug_to_same_title
    self.slug = title if slug != title
  end
end
