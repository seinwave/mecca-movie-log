# frozen_string_literal: true

# spec/factories/ratings.rb

FactoryBot.define do
  factory :rating do
    watched_date { '2022-01-01' }
    score { 5 }
    association :user, factory: :user
    association :movie, factory: :movie
  end
end
