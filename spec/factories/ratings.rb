# frozen_string_literal: true

# spec/factories/ratings.rb

require 'faker'

FactoryBot.define do
  factory :rating do
    id { Faker::Number.number(digits: 10) }
    watched_date { Faker::Date.between(from: '2019-01-01', to: '2024-01-01') }
    score { 5 }
    association :user, factory: :user
    association :movie, factory: :movie
    factory :rating_with_same_date do
      watched_date { '2020-01-24' }
    end
    factory :rating_with_same_movie_and_same_date do
      watched_date { '2020-01-24' }
      association :movie, factory: :movie
    end
  end
end
