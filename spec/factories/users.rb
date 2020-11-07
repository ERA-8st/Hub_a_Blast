FactoryBot.define do

  factory :user do
    user_name  {"test1"} 
    email  {"0@0"} 
    password  {"000000"} 
  end

  factory :user2, class: User do
    user_name {"test2"}
    email {"2@2"}
    password {"222222"}
  end
end
