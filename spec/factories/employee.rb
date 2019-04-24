# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password Faker::Internet.password
    email { Faker::Internet.email }
    office

    %i[other developer system_administrator manager team_lead admin].each do |role|
      trait role do
        role role.to_s
      end
    end

    trait :deleted do
      role 'other'
      deleted true
    end
  end
end

