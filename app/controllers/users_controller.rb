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

end