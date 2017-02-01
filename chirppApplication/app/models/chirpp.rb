class Chirpp < ActiveRecord::Base
  belongs_to :user_profile
  default_scope -> { order(created_at: :desc) }
  validates :user_profile_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
