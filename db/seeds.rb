User.create!(name: "guest",
            email: "guest@example.com",
            password:              "password",
            password_confirmation: "password",
            image: open("#{Rails.root}/app/assets/images/guest.jpeg"))

User.create!(name:  "taro yamada",
            email: "a@a.com",
            password:              "aaaaaa",
            password_confirmation: "aaaaaa")

User.create!(name:  "jiro tanaka",
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



title_and_url = {
  "Starbucks Music: 3 Hours of Happy Starbucks Music with Starbucks Music Playlist Youtube" => "rMurJ6SxuHs",
  "Home Bossa: Happy Bossa Nova & Morning Jazz Coffee Music for Good Mood and Wake Up" => "3N0K0_9cvcg",
  "2012MLB10　ダルビッシュVSイチロー2度目の対決" => "e57zbXC4Y5k",
  "「常識人間」は成功しない" => "L99WnfYCeXg",
  "嵐 - Monster [Official Music Video]" => "JedKBJVHhiE",
  %Q[NBA "Don't Reach" MOMENTS] => "ZPX4hTEdQaw"
}
title_and_url.each do |key, value|
  User.first.posts.create!(title: key, youtube_url: value)
end
# @post = User.first.posts.create!(title: 'Starbucks Music: 3 Hours of Happy Starbucks Music with Starbucks Music Playlist Youtube',
#                         youtube_url: 'rMurJ6SxuHs')
#
# @post2 = User.first.posts.create!(title: 'Home Bossa: Happy Bossa Nova & Morning Jazz Coffee Music for Good Mood and Wake Up',
#                         youtube_url: '3N0K0_9cvcg')
#
# @post3 = User.first.posts.create!(title: '2012MLB10　ダルビッシュVSイチロー2度目の対決',
#                         youtube_url: 'e57zbXC4Y5k')
#
#
# @post4 = User.second.posts.create!(title: '「常識人間」は成功しない',
#                         youtube_url: 'L99WnfYCeXg')


# リレーションシップ
users = User.all
posts = Post.all

guest  = users.first
following = users[2..30]
followers =  users[3..20]
likers = users[0..40]
reviewers = users[1..5]

following.each {|followed| guest.follow(followed) }
followers.each { |follower| follower.follow(guest) }


likers.each do |liker|
  posts.each do | post |
    liker.likes.create!(post_id: post.id)
  end
end

reviewers.each do |reviewer|
  posts.each do | post |
    reviewer.comments.create!(content: Faker::Lorem.paragraph(sentence_count = 4), user_id: reviewer.id, post_id: post.id)
  end
end
