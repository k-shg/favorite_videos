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
