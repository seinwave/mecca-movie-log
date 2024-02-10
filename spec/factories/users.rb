# frozen_string_literal: true

# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "User#{n}" }
    sequence(:last_name) { |n| "Last#{n}" }
  end
end
