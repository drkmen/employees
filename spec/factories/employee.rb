# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }
    email { Faker::Internet.email }
    role { :developer }
    status { :free }
    office
    department

    Employee::ROLES.each do |role|
      trait role do
        role { role }
      end
    end

    trait :deleted do
      role { :other }
      deleted_at { DateTime.now }
    end
  end
end

