FactoryBot.define do
  factory :skill do
    name Faker::Name.title
    level Faker::Number.number(2)
    experience Faker::Name.title
  end
end