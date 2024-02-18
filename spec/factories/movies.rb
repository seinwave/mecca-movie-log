# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
  end
end
