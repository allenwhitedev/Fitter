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
end
