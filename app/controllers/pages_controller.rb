class PagesController < ApplicationController

def home
	if signed_in?
		@feat = current_user.feats.build 
		@feed_items = current_user.feed.paginate(
			page: params[:page])
	else
		@feed_items = []
	end	
end

def other_sites 
end

def about
end

def empty_title
end

end 