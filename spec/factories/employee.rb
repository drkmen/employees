FactoryBot.define do
  factory :employee do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password
    email { Faker::Internet.email }

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
    end

    trait :deleted do
      role 'other'
      deleted true
    end
  end
end

