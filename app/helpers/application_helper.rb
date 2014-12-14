module ApplicationHelper

# Provides a title for a page when none is provided
def titler(page_title = "")
	default_title = "Fitter"
	if page_title.empty?
		default_title
	else
		page_title
	end
end

end
