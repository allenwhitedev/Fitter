# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
99.times do |n|
	name = Faker::Name.name
	email = "FitGuy-#{n+1}@gmail.com"
	User.create!(name: name, email: email,
		password:"secretpassword", 
		password_confirmation: "secretpassword")
end


# Feats for the first six users
users = User.order(:created_at).take(6)
50.times do
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.feats.create!(content: content) }
end

# Relationships for following
users = User.all 
user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }