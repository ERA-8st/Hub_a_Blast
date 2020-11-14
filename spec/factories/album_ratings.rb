FactoryBot.define do
  factory :album_rating do
    association :user
    album_id { "0hpTzafFBuqoBqt5mwWBjU" }
    rate { 4.5 }
  end
end
