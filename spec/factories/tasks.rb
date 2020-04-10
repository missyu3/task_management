FactoryBot.define do
  factory :task do
    title { "test1"}
    content { "testes1" }
    status { 0 }
    limit { 2000/01/01 }
  end
end
