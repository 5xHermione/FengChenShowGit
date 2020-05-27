# 豐臣秀Git 使用說明

* Ruby 版本：2.6.5
* Rail 版本：6.0.2.2
* 資料庫：postgres
* 寄信功能：sendgrid

# 開發團隊

  ### 林季霆
  轉職前是：公司管理人
  想說的話：準父親、苗栗的半個野人。野人還俗記進行中...待續。
  ##### 聯絡方式：
   * [Github](https://github.com/Lawa0921)
  ### 鄭羽珊
  轉職前是：英文小老師
  想說的話：夢想成為一個又溫柔又強大又會 coding 的哥吉拉。
  ##### 聯絡方式：
   * [Github](https://github.com/godzillalabear)

  ### 林俊廷
  轉職前是：UI / UX 設計師
  想說的話：程式這條旅途很長遠，但至少踏出了一步
  ##### 聯絡方式：
   * [Github](https://github.com/Eric032333)

  ### 邱詠絮
  轉職前是：設計企劃
  想說的話：朋友看到我 coding 以為世界末日，事實上地球依然轉得好好w
  ##### 聯絡方式：
   * [Github](https://github.com/123-Shelly)
# 使用說明
注意：你必須安裝 ruby 2.6.5 才能使用
### 步驟一：取得套件
* 使用終端機進入專案目錄
* 輸入 yarn --check-files
* 輸入 bundle
### 步驟二：建立資料庫、資料表
* 將 db/database.yml.example 更名為 database.yml，並輸入您需要的設定
* 執行 rails db:create
* 執行 rails db:migrate
### 步驟三：功能設定
* 將 config/application.yml.example 更名為 application.yml
* 依照檔案指示輸入所需的環境變數
### 步驟四：開啟 server
* 回到終端機並輸入 rails s
* 打開瀏覽器並輸入 localhost:3000 即可進入專案
