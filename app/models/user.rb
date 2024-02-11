# frozen_string_literal: true

class User < ApplicationRecord
  has_many :ratings

  validates :first_name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 100 }
end
