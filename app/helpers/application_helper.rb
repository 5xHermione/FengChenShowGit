module ApplicationHelper


	def backcolor_class

	end


	def background_class
		return "" if user_signed_in?
		return "back" if homepage?
		""
	end



	def homepage?
		params[:controller]=="home" && params[:action] == "index"
	end

end
