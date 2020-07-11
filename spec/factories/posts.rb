FactoryBot.define do
  factory :one, class: Post do
    title { "バスケを知らない人に見せたいダンク" }
    youtube_url { "SsmfYJEamyU" }
    category_id { 2 }
    association :user, factory: :taro
    association :category, factory: :sports
  end

  factory :two, class: Post do
    title { "One Love" }
    youtube_url { "fk2URdKTrmQ" }
    category_id { 1 }
    association :user, factory: :jiro
    association :category, factory: :music
  end

  factory :three, class: Post do
    title { "サンプル３" }
    youtube_url { "adiufapdio" }
    category_id { 1 }
    association :user, factory: :sanji
    association :category, factory: :sports
  end

  factory :music, class: Category do
    name { "music" }
  end

  factory :sports, class: Category do
    name { "sports" }
  end

  factory :comment01, class: Comment do
    content { "aaaaaaaaaaaaaaaaaaaaaaaa" }
    association :Post, factory: :three
    association :user, factory: :sanji
  end
end
