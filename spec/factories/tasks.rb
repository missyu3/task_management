FactoryBot.define do
  factory :task do
    title { "test1"}
    content { "testes1" }
    status { 1 }
    limit { "2024-05-23" }
    priority { 2 }
    user_id { 1 }
  end
end
