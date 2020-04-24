FactoryBot.define do
  factory :user do
    id { 1 }
    name { "user1"}
    email { "user@user.com" }
    password { "password" }
  end
end
