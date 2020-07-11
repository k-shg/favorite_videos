FactoryBot.define do
  factory :taro, class: User do
    name { "taro yamada" }
    email { "a@a.com" }
    password             { "password" }
    password_confirmation { "password" }

  end

  factory :jiro, class: User do
    name { "jiro tanaka" }
    email { "b@b.com" }
    password             { "password" }
    password_confirmation { "password" }
  end

  factory :sanji, class: User do
    name { "sanji" }
    email { "sanji@sample.com" }
    password             { "password" }
    password_confirmation { "password" }
  end
end
