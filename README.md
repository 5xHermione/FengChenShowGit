# 豐臣秀Git

* Ruby 版本：2.6.5
* Rail 版本：6.0.2.2
* 資料庫：postgreSQL
* 寄信功能：sendgrid

# 使用說明
注意：你必須安裝 ruby 2.6.5 才能使用
### 步驟一：取得套件
* 使用終端機進入專案目錄
* 輸入 yarn --check-files
* 輸入 bundle
### 步驟二：建立資料庫、資料表
* 在 config 資料夾建立 database.yml 檔案
* 將 config/database.yml.example 的內容貼進去 database.yml，並更改您需要的設定
* 執行 rails db:create
* 執行 rails db:migrate
### 步驟三：功能設定
* 在 config 資料夾建立 application.yml 檔案
* 將 config/application.yml.example 的內容貼進去 application.yml
* 依照檔案指示輸入所需的環境變數
### 步驟四：開啟 server
* 回到終端機並輸入 rails s
* 打開瀏覽器並輸入 localhost:3000 即可進入專案

### 使用者註冊問題
* 按下註冊後，terminal 會出現以下文字
```
<p>Welcome user@mail.com!</p>

<p>You can confirm your account email through the link below:</p>

<p><a href="http://localhost:3000/confirmation?confirmation_token=XkV11ZB8t_gXNXg1dLTP">Confirm my account</a></p>
```
* 請複製當中的連結至瀏覽器，使用者即註冊完成

# 開發團隊

  ### 林季霆
  * [Github](https://github.com/Lawa0921)
  ### 鄭羽珊
  * [Github](https://github.com/godzillalabear)
  ### 林俊廷
  * [Github](https://github.com/Eric032333)
  ### 邱詠絮
  * [Github](https://github.com/123-Shelly)
