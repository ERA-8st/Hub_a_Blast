FactoryBot.define do
  factory :song_comment do
    association :user
    comment { "test" }
    song_id { "4VXIryQMWpIdGgYR4TrjT1" }
  end
  factory :song_comment2, class: SongComment do
    comment { "test" }
    song_id { "4VXIryQMWpIdGgYR4TrjT1" }
  end
end
