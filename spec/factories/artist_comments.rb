FactoryBot.define do
  factory :artist_comment do
    association :user
    comment { "artist_comment_test" }
    artist_id {  "4STHEaNw4mPZ2tzheohgXB" }
  end
  factory :artist_comment2, class: ArtistComment do
    comment { "artist_comment2_test" }
    artist_id { "4STHEaNw4mPZ2tzheohgXB" }
  end
end