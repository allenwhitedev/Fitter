class Feat < ActiveRecord::Base

	default_scope -> { order(created_at: :desc) }

  belongs_to :user
  validates_presence_of :user_id
  validates :content, presence: true, length: { in: 8..1000 }
end
