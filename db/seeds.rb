User.create!(name:  "aaa",
            email: "a@a.com",
            password:              "aaaaaa",
            password_confirmation: "aaaaaa")

User.create!(name:  "bbb",
            email: "b@b.com",
            password:              "aaaaaa",
            password_confirmation: "aaaaaa")


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@service.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

User.first.posts.create!(title: 'Starbucks Music: 3 Hours of Happy Starbucks Music with Starbucks Music Playlist Youtube',
                        youtube_url: 'rMurJ6SxuHs')

User.first.posts.create!(title: 'Home Bossa: Happy Bossa Nova & Morning Jazz Coffee Music for Good Mood and Wake Up',
                        youtube_url: '3N0K0_9cvcg')

User.first.posts.create!(title: '2012MLB10　ダルビッシュVSイチロー2度目の対決',
                        youtube_url: 'e57zbXC4Y5k')


User.second.posts.create!(title: '「常識人間」は成功しない',
                        youtube_url: 'L99WnfYCeXg')


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
