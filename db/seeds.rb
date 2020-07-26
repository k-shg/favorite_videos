#初期データ

[ ["guest", "guest@example.com", "password", "password", open("#{Rails.root}/app/assets/images/guest.jpeg") ],
  ["taro yamada", "a@a.com", "password", "password", open("#{Rails.root}/app/assets/images/cat.jpg") ],
  ["YUKO", "b@b.com", "password", "password", open("#{Rails.root}/app/assets/images/woman.jpg")]
].each do | name, email, password, password_confirmation, image |
  User.create!(name: name, email: email, password: password, password_confirmation: password_confirmation, image: image)
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@service.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


[ "エンタメ", "ビジネス", "お笑い", "Youtuber", "恋愛", "アニメ", "スポーツ", "音楽", "自己啓発", "ニュース", "映画" ].each {|category| Category.create!(name: category) }

[ [  "Starbucks Music: 3 Hours of Happy Starbucks Music with Starbucks Music Playlist Youtube",  "rMurJ6SxuHs",  "音楽" ],
  [  "Home Bossa: Happy Bossa Nova & Morning Jazz Coffee Music for Good Mood and Wake Up",  "3N0K0_9cvcg",  "音楽" ],
  [  "2012MLB10　ダルビッシュVSイチロー2度目の対決",  "e57zbXC4Y5k",  "スポーツ" ],
  [  "「常識人間」は成功しない" , "L99WnfYCeXg", "自己啓発 "],
  [  "嵐 - Monster [Official Music Video]" , "JedKBJVHhiE", "音楽 "],
  [  %Q[NBA "Don't Reach" MOMENTS] , "ZPX4hTEdQaw", "音楽 "],
  [  "the Fourth Avenue Cafe" , "xSWFEGVjmQ8", "音楽"],
  [  "Super Mario Beatbox" , "LE-JN7_rxtE", "Youtuber"],
  [  "【好きなことで、生きていく】『レペゼン地球-DJ社長-』" , "PPnbEiXSYM8", "Youtuber"],
  [  "当たりはなかった？祭りくじで悪事を働く一部始終をban覚悟で完全公開します" , "30roBDlCA7k", "Youtuber"],
  [  "【修羅場】お店の客が全員ラファエルの元カノドッキリ【ラファエル】", "zLXZpFftHVk", "Youtuber"],
  [  "たくさんの男性YouTuberで恋ダンス踊ってみた。" , "V502qWGmLFk", "Youtuber"],
  [  "【シバター監修MV】俺たち金持ちYouTuber/カルxピン（11thシングル）" , "fytyMTaF1x4", "Youtuber"],
  [  "GLAY / HOWEVER" , "gPcPseeICjs", "音楽"],
  [  "TVアニメ「進撃の巨人」The Final Season　PV" , "SlNpRThS9t8", "アニメ"],
  [  "リヴァイ VS 獣の巨人(ジーク) 進撃の巨人 Season3 Part2" , "UPKs2ZuQ3ac", "アニメ"],
  [  "【公式】テニスの王子様 第65話「青学の柱になれ」" , "Llhu-L9r-8k", "アニメ"],
  [  "One Love" , "fk2URdKTrmQ", "音楽"],
  [  "友達の家の壁1面をポケモンカードしてみた【ドッキリ】" , "sy-RzyvMkLg", "Youtuber"],
  [  "残り0.9秒！高校バスケ・小学生ミニバスで起きた奇跡のブザービーター 終了間際の大逆転が感動的すぎる！！！Twitterで話題沸騰中！！" , "1QYby70Trqo", "スポーツ"],
  [  "Kei Nishikori vs Pablo Carreno Busta - Full Fifth Set Tiebreak | Australian Open 2019 4R" , "zNZ9EtnceqA", "スポーツ"],
  [  "バスケを知らない人に見せたいダンク" , "SsmfYJEamyU", "スポーツ"]
].each do |title, url, category|
    User.first.posts.create!(title: title, youtube_url: url, category_id: Category.find_by(name: category).id)
end

# リレーションシップ
users = User.all
posts = Post.all

guest  = users.first
following = users[2..30]
followers =  users[3..20]
likers = users[0..40]
reviewers = users[1..5]

following.each { |followed| guest.follow(followed) }
followers.each { |follower| follower.follow(guest) }


likers.each do |liker|
  posts.each do | post |
    liker.likes.create!(post_id: post.id) if [true, false].sample
  end
end

reviewers.each do |reviewer|
  posts.each do | post |
    if [true, false].sample
      reviewer.comments.create!(
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph(sentence_count = 5),
        rate: Random.rand(0..5),
        user_id: reviewer.id,
        post_id: post.id
      )
    end
  end
end
