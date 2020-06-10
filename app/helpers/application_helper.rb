module ApplicationHelper
	def to_markdown(text)
    html_render_options = {
      filter_html:     true, # no input tag or textarea
      hard_wrap:       true,
      link_attributes: { rel: 'external nofollow' }
    }

    markdown_options = {
      autolink:           true,
      fenced_code_blocks: true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true,
      lax_html_blocks:    true,
      tables:             true,
      prettify:           true,
      disable_indented_code_blocks: true,
    }

    renderer = Redcarpet::Render::HTML.new(html_render_options)
    markdown = Redcarpet::Markdown.new(renderer, markdown_options)
    raw markdown.render(text)
  end

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

