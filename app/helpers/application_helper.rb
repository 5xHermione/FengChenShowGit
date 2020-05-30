module ApplicationHelper
	# def background_class
	# 	if params[:controller]=="home" && params[:action] == "index" && !(user_signed_in?)
	# 		return "back"
	# 	else
	# 		return ""
	# 	end
	# end

  # def backcolor_class
	# 	if params[:controller]=="home" && params[:action] == "index" && !(user_signed_in?)
	# 		return "backcolor"
	# 	else
	# 		return ""
	# 	end
	# end

	def backcolor_class
	# 	return "" if user_signed_in?
	# 	return "backcolor" if homepage?
	# 	""
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
