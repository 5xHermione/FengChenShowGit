class Blacklist < ApplicationRecord
end

# 包含 blacklist = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
# 進入 rails console 執行：一、 blacklist = ["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"]
#                          二、 blacklist.each do |b|
#                          三、   Blacklist.create(name: b)
#                          四、 end   
