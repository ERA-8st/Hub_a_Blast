FactoryBot.define do
  factory :song_comment do
    association :user
    comment { "song_comment_test" }
    song_id { "4VXIryQMWpIdGgYR4TrjT1" }
  end
  factory :song_comment2, class: SongComment do
    comment { "song_comment2_test" }
    song_id { "4VXIryQMWpIdGgYR4TrjT1" }
  end
end
