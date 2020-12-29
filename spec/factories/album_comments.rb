FactoryBot.define do
  factory :album_comment do
    association :user
    comment { "album_comment_test" }
    album_id { "0qsh1whWV3FcVaM6A8vLN9" }
  end
  factory :album_comment2, class: AlbumComment do
    comment { "album_comment2_test" }
    album_id { "0qsh1whWV3FcVaM6A8vLN9" }
  end
end
