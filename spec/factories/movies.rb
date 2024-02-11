# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
  end
end
