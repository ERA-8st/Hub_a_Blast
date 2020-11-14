FactoryBot.define do
  factory :song_rating do
    association :user
    song_id { "4R0MMvohDGMEjTNqVh2zUj" }
    rate { 4.5 }
  end
end
