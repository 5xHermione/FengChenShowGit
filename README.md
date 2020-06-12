# 豐臣秀Git
這個專案是個復刻 GitHub 的練習專案，可以透過 SSH 連線 push repo，檢視專案內容，pull requests，以及合併分支。

* Ruby 版本：2.6.5
* Rail 版本：6.0.2.2
* 資料庫：postgreSQL


# 使用說明
注意：你必須安裝 ruby 2.6.5 才能使用
### 步驟一：取得套件
* 本專案有使用 [rmagick](https://github.com/rmagick/rmagick) ，你可能會需要先在電腦安裝 Imagick
* 本專案還有使用 [GitHub-linguist](https://github.com/github/linguist)，你也會需要安裝 cmake, pkg-config, icu4c 等套件
* 使用終端機進入專案目錄
* 輸入 `yarn --check-files`
* 輸入 `bundle`

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

# 開發團隊

### 林季霆
* [Github](https://github.com/Lawa0921)
### 鄭羽珊
* [Github](https://github.com/godzillalabear)
### 林俊廷
* [Github](https://github.com/Eric032333)
### 邱詠絮
* [Github](https://github.com/123-Shelly)
