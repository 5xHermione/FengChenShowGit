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
  
  def need_turbolinks?
    if params[:controller]=="issues" && params[:action] == "index" 
      return false 
    elsif  params[:controller]=="pull_requests" && params[:action] == "index" 
      return false
    else
      return true
    end
  end

end

