FactoryBot.define do
  factory :artist_comment do
    association :user
    comment { "test" }
    artist_id {  "2MqhkhX4npxDZ62ObR5ELO" }
  end
end
