# frozen_string_literal: true

FactoryBot.define do
  factory :office do
    name { Faker::Company.name }
  end
end
