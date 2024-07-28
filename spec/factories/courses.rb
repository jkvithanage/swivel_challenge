FactoryBot.define do
  factory :course do
    association :category
    name { Faker::Educator.course_name }
    author { Faker::Name.name }
    state { :active }
  end
end
