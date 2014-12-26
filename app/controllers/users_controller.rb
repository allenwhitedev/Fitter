class UsersController < ApplicationController

	def new
	end

	def show
		@user = User.find(params[:id])
		@feats = @user.feats.paginate(page: params[:page])
	end

	def index
	end

	def destroy
	end

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(
			page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(
			page: params[:page])
		render 'show_follow'
	end

end