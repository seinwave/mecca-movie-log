# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :ratings

  validates :title, presence: true, length: { minimum: 1, maximum: 600 } # about 3x the length of the longest title ever made
end
