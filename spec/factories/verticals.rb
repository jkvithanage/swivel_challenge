FactoryBot.define do
  factory :vertical do
    name { Faker::IndustrySegments.industry }
  end
end
