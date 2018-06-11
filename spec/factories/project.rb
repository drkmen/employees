# frozen_string_literal: true

# Factory Project
FactoryBot.define do
  factory :project do
    name Faker::Name.name
    description Faker::Lorem.sentence
    client Faker::Name.name
    start_date Time.now.utc
    end_date Time.now.utc
    association :employee_id, factory: :employee
  end
  factory :invalid_project, parent: :project do
    name nil
    description nil
    client nil
    start_date nil
    end_date nil
  end
end

