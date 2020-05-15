["edit", "login", "logout", "password", "new", "cancel", "register", "confirmation", "repositories", "issues", "rails"].each do |word|
  Blacklist.create(name: word)
end

# clone 專案後執行 rails db:seeds 用於建立黑名單資料
