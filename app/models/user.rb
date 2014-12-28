class User < ActiveRecord::Base
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable
before_save { self.email = email.downcase }

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :name, presence: true, length: { in: 2..50 }
validates :email, presence: true, length: { in: 2..75 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

has_many :feats, dependent: :destroy	

# Following
has_many :active_relationships, 
	class_name: "Relationship",
	foreign_key: "follower_id", dependent: :destroy

has_many :following, through: :active_relationships, 
	source: :followed


# Followers
has_many :passive_relationships, 
	class_name: "Relationship",
	foreign_key: "followed_id", dependent: :destroy									

has_many :followers, through: :passive_relationships,
	source: :follower



def feed
	# Other way of expressing
	# Feat.where("user_id in (?) OR user_id = ?",
	#	following_ids, id)
	following_ids = "SELECT followed_id FROM 
	relationships WHERE follower_id = :user_id"
	Feat.where("user_id IN (#{following_ids}) 
		OR user_id = :user_id", user_id: id)
end

def follow(other_user)
	active_relationships.create(
		followed_id: other_user.id)
end

def unfollow(other_user)
	active_relationships.find_by(
		followed_id: other_user.id).destroy
end

def following?(other_user)
	following.include?(other_user) 
end

end
