# Favarite Videos
[![Rails](https://img.shields.io/badge/Rails-v5.2.4.3-%23a72332)](https://rubygems.org/gems/rails/versions/5.2.4.3)
[![mysql](https://img.shields.io/badge/MYSQL-5.7-blue)](https://openstandia.jp/oss_info/mysql/version/)


<img width="1440" alt="スクリーンショット 2020-07-06 16 18 33" src="https://user-images.githubusercontent.com/21212701/91660281-5ec20880-eb10-11ea-9c20-5d7f067b5a7b.png">

## :full_moon: 概要
Youtubeで心に残った動画を登録して共有するアプリです。
好みが似たユーザーと繋がることで、自分好みの新しい動画を見つけることができます。

### :earth_americas: App URL
https://calm-caverns-57605.herokuapp.com/

### :eyes: テストアカウント

ログインページに「かんたんログイン」ボタンをクリックするとログイン可能となっております。アプリを使用する際はこちらをご利用ください。  

# :fire: 機能一覧
- ユーザー登録、編集機能  
- ログイン、ログアウト機能  
- 動画の登録、削除機能  
- レビューの登録、編集、削除機能    
- ユーザーフォロー登録、削除機能  
- 動画、ユーザーの検索機能


# :crystal_ball: 使用技術一覧
### フロントエンド
- HTML (ERB)  
- CSS (Sass)  
- JavaScript (Jquery)
### バックエンド  
- Ruby (2.7.1)  
- Rails (5.2.4)  
### サーバー  
- Puma (3.12.6 )  
- Nginx
### DB  
- MYSQL(5.7)  
### インフラ 開発環境等
- Docker/docker-compose
- Supervisor
- CircleCI (CI/CD)
- RSpec
- AWS(Route53, VPC, EC2, S3, IAM)  
- Terraform
- Ansible


# :computer: 制作背景
個人的にYoutubeが大好きで、心に残ったお気に入りの動画を共有したいという気持ちがありました。「レビュー形式で評価の高い動画を見つけられる」利便性を図りたく作成しました。

# :sunny: 工夫した点
### Youtube APIとの連携
YoutubeのURLからタイトルを取得できるようAPIを連携したことです。
ユーザーはURLを打ち込むだけで動画を登録することができるようになりました。

### インフラの自動化とコード化
Terraform、Ansibleを使ってインフラのコード化を実現し、メンテナンス性を高めました。
また、CircleCIで自動テスト・自動デプロイをすることで開発を効率化しました。
