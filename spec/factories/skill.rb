# frozen_string_literal: true

# Factory Skill
FactoryBot.define do
  factory :skill do
    name { Faker::Job.title }
  end
end
