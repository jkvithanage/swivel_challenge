FactoryBot.define do
  factory :category do
    association :vertical
    name { Faker::Commerce.department }
    state { :active }
  end
end
