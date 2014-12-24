class PagesController < ApplicationController

def home
	@feat = current_user.feats.build if signed_in?
end

def other_sites 
end

def about
end

def empty_title
end

end 