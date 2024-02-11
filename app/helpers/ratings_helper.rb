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

  def render_rating(rating)
    return "#{rating.user.first_name} didn't watch it." if rating.nil?

    score = rating.score
    score = score.round
    SCORE_TO_LETTER_GRADE[score]
  end

end
