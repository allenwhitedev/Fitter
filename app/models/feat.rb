class Feat < ActiveRecord::Base

default_scope -> { order(created_at: :desc) }

belongs_to :user
validates_presence_of :user_id
validates :content, presence: true, length: { in: 8..1000 }
validate :pic_size

mount_uploader :picture, PictureUploader

private

# Limits size of pic uploads
def pic_size
	if picture.size > 5.megabytes
		errors.add(:picture, "file must be smaller 
			than 5MB")
	end
end

end
