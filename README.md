# Favarite Video

<img width="1440" alt="スクリーンショット 2020-07-06 16 18 33" src="https://user-images.githubusercontent.com/21212701/86566399-8a0ef800-bfa4-11ea-92e5-fe2b1b916e71.png">

## 概要
Youtubeで心に残った動画を登録して共有するアプリです。
好みが似たユーザーと繋がることで、自分好みの新しい動画を見つけることができます。

### URL
https://calm-caverns-57605.herokuapp.com/

### テストアカウント
ログインページに「かんたんログイン」ボタンをクリックするとログイン可能となっております。アプリを使用する際はこちらをご利用ください。  

# 機能一覧
・ユーザー登録、編集機能  
・ログイン、ログアウト機能  
・動画の登録、削除機能  
・レビューの登録、編集、削除機能    
・ユーザーフォロー登録、削除機能  
・動画、ユーザーの検索機能  

# 使用技術一覧
### フロントサイド
・HTML (ERB)  
・CSS (Sass)  
・JavaScript (Jquery)  
### バックエンド  
・Ruby (2.7.1)  
・Rails (5.2.4)  
### サーバー  
・Puma (3.12.6 )  
### DB  
・PostgreSQL(12.3)  
### インフラ・開発環境等  (実装中)
・Docker/docker-compose  
・CircleCI (CI/CD)  
・Rubocop  
・RSpec  
・AWS(Route53, ALB, ACM, VPC, EC2, S3)  

# 制作背景
個人的にYoutubeが大好きで、心に残ったお気に入りの動画を共有したいという気持ちがありました。「レビュー形式で評価の高い動画を見つけられる」利便性を図りたく作成しました。

# 工夫した点
### Youtube APIとの連携
YoutubeのURLからタイトルを取得できるようにAPIを連携したことです。
ユーザーはURLを打ち込むだけで動画を登録することができるようになりました。
###　検索機能のロジック実装
