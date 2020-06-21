FactoryBot.define do
  factory :user do
    id { 1 }
    name { "user1"}
    email { "user@user.com" }
    password { "password" }
    admin { false }
  end
end
