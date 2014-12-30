class FeatsController < ApplicationController

#before_action :authenticate_user!, only: [:create, :destroy]
before_action :correct_user, only: :destroy

def create
	@feat = current_user.feats.build(feat_params)
	if @feat.save
		flash[:success] = "Feat posted"
		redirect_to root_url
	else
		@feed_items = []
		render 'pages/home'
	end
end

def destroy
	@feat.destroy
	flash[:success] = "Feat deleted"
	redirect_to request.referrer || root_url
end

def show
end

private

def feat_params
	params.require(:feat).permit(:title, :content, :picture)
end

def correct_user
	@feat = current_user.feats.find_by(id: params[:id])
	redirect_to root_url if @feat.nil?
end

end