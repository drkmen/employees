FactoryBot.define do
  factory :skill do
    name Faker::Name.title
    experience Faker::Name.title
  end
end
