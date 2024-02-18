# frozen_string_literal: true

# spec/factories/users.rb

require 'faker'

FactoryBot.define do
  factory :user do
    id { Faker::Number.number(digits: 10) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
