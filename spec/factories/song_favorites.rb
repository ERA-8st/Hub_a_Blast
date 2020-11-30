FactoryBot.define do
  factory :song_favorite do
    association :user
    song_id { "4VXIryQMWpIdGgYR4TrjT1" }
  end
end
