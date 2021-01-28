FactoryBot.define do
  factory :notification do
    
  end

  factory :follow_notification, class: Notification do
    action { "follow" }
    checked { "false" }
  end
end
