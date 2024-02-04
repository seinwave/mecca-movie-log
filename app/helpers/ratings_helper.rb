# frozen_string_literal: true

module RatingsHelper
  SCORE_TO_LETTER_GRADE = {
    15 => 'A+',
    14 => 'A',
    13 => 'A-',
    12 => 'B+',
    11 => 'B',
    10 => 'B-',
    9 => 'C+',
    8 => 'C',
    7 => 'C-',
    6 => 'D+',
    5 => 'D',
    4 => 'D-',
    3 => 'F+',
    2 => 'F',
    1 => 'F-',
    -2000 => 'Fart Minus'
  }.freeze

  def convert_to_letter_grade(rating)
    score = rating.score
    SCORE_TO_LETTER_GRADE[score]
  end

  def running_average(users)
    averages = []
    users.each do |user|
      ratings = Rating.where(user_id: user.id)
      averages << ratings.average(:score)
    end

    return (averages.sum / averages.length).round(1)
  end
end
