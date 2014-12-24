class FeatsController < ApplicationController

before_action :authenticate_user!, only: [:create, :destroy]

def create
	@feat = current_user.feats.build(feat_params)
	if @feat.save
		flash[:success] = "Feat posted"
		redirect_to root_url
	else
		render 'root_url'
	end
end

def destroy
end

def show
end

private

def feat_params
	params.require(:feat).permit(:title, :content)
end

end