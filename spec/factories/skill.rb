# frozen_string_literal: true

FactoryBot.define do
  factory :skill do
    name { Faker::Job.title }
  end
end
