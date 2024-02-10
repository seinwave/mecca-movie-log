# frozen_string_literal: true

# spec/factories/movies.rb

FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
  end
end
