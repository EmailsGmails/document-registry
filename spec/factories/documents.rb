FactoryBot.define do
  factory :document do
    title { "MyString" }
    content { "MyText" }
    user { nil }
    created_at { "2023-12-01 14:23:42" }
  end
end
