module CodeHelper

 def code(line, file_name)
  if file_name.match(/\.html/)
    line.gsub("&", "&amp")
        .gsub("<", "&lt")
        .gsub(">", "&gt")
        .gsub(" ", "&nbsp")
  else
    line.gsub(" ", "&nbsp")
  end
 end

end
