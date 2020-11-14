FactoryBot.define do
  factory :album_comment do
    association :user
    comment { "test" }
    album_id { "2zE1YKY7Okj10Tjl09jjth" }
  end
end
