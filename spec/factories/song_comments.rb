FactoryBot.define do
  factory :song_comment do
    association :user
    comment { "test" }
    song_id { "2PnMMlB7UMaqQBYa1vGPHz" }
  end
end
