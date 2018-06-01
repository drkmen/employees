FactoryBot.define do
  factory :employee do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    created_at Time.now.utc
    updated_at Time.now.utc

    trait :other do
      role 'other'
    end

    trait :programmer do
      role 'programmer'
    end

    trait :manager do
      role 'manager'
    end

    trait :team_lead do
      role 'team_lead'
    end

    trait :admin do
      role 'admin'
    end

    trait :admin_full do
      role 'admin'
      password Faker::Internet.password
    end
  end
end