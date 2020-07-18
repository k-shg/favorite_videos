User.create!( name: "guest",
            email: "guest@example.com",
            password:              "password",
            password_confirmation: "password",
            image: open("#{Rails.root}/app/assets/images/guest.jpeg"))

User.create!(name:  "taro yamada",
            email: "a@a.com",
            password:              "password",
            password_confirmation: "password")

User.create!(name:  "jiro tanaka",
            email: "b@b.com",
            password:              "password",
            password_confirmation: "password")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@service.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


category_list = ["エンタメ", "ビジネス", "お笑い", "Youtuber", "恋愛", "アニメ", "スポーツ", "音楽", "自己啓発", "ニュース", "映画"]

category_list.each do | category |
  Category.create!(name: category)
end


# hash = { m1: {title: "Starbucks Music: 3 Hours of Happy Starbucks Music with Starbucks Music Playlist Youtube",url: "rMurJ6SxuHs", category: 7 } }

viedos_info = {
  "Starbucks Music: 3 Hours of Happy Starbucks Music with Starbucks Music Playlist Youtube" =>  "rMurJ6SxuHs",
  "Home Bossa: Happy Bossa Nova & Morning Jazz Coffee Music for Good Mood and Wake Up" => "3N0K0_9cvcg",
  "2012MLB10　ダルビッシュVSイチロー2度目の対決" => "e57zbXC4Y5k",
  "「常識人間」は成功しない" => "L99WnfYCeXg",
  "嵐 - Monster [Official Music Video]" => "JedKBJVHhiE",
  %Q[NBA "Don't Reach" MOMENTS] => "ZPX4hTEdQaw",
  "the Fourth Avenue Cafe" => "xSWFEGVjmQ8",
  "Super Mario Beatbox" => "LE-JN7_rxtE",
  "【好きなことで、生きていく】『レペゼン地球-DJ社長-』" => "PPnbEiXSYM8",
  "当たりはなかった？祭りくじで悪事を働く一部始終をban覚悟で完全公開します" => "30roBDlCA7k",
  "【修羅場】お店の客が全員ラファエルの元カノドッキリ【ラファエル】"=> "zLXZpFftHVk",
  "たくさんの男性YouTuberで恋ダンス踊ってみた。" => "V502qWGmLFk",
  "【シバター監修MV】俺たち金持ちYouTuber/カルxピン（11thシングル）" => "fytyMTaF1x4",
  "GLAY / HOWEVER" => "gPcPseeICjs",
  "TVアニメ「進撃の巨人」The Final Season　PV" => "SlNpRThS9t8",
  "リヴァイ VS 獣の巨人(ジーク) 進撃の巨人 Season3 Part2" => "UPKs2ZuQ3ac",
  "【公式】テニスの王子様 第65話「青学の柱になれ」" => "Llhu-L9r-8k",
  "One Love" => "fk2URdKTrmQ",
  "友達の家の壁1面をポケモンカードしてみた【ドッキリ】" => "sy-RzyvMkLg",
  "残り0.9秒！高校バスケ・小学生ミニバスで起きた奇跡のブザービーター 終了間際の大逆転が感動的すぎる！！！Twitterで話題沸騰中！！" => "1QYby70Trqo",
  "Kei Nishikori vs Pablo Carreno Busta - Full Fifth Set Tiebreak | Australian Open 2019 4R" => "zNZ9EtnceqA",
  "バスケを知らない人に見せたいダンク" => "SsmfYJEamyU"
}

viedos_info.each do |key, value|
  User.first.posts.create!(title: key, youtube_url: value, category_id: Random.rand(1..10))
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
    reviewer.comments.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph(sentence_count = 5), rate: Random.rand(0..5), user_id: reviewer.id, post_id: post.id) if [true, false].sample
  end
end
