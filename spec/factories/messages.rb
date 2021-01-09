FactoryBot.define do
  factory :message do
    message { "message1" }
  end
  factory :message2, class: Message do
    message { "message2" }
  end
end