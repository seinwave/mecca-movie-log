# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
  end
end
