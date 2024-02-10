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

  def get_ratings(users, movie)
    users = Array(users || User.all)
    Rating.where(user_id: users.map(&:id), movie_id: movie.id).to_a
  end

  def get_complimentary_rating(rating)
    Rating.where(movie_id: rating.movie_id).where.not(user_id: rating.user_id).first
  end

  def convert_to_letter_grade(rating)
    score = rating.score
    score = score.round
    SCORE_TO_LETTER_GRADE[score]
  end

  def convert_score_to_letter_grade(score)
    score = score.round
    SCORE_TO_LETTER_GRADE[score]
  end

  def running_average(users)
    users = User.all if users.empty?
    averages = []
    users.each do |user|
      ratings = Rating.where(user_id: user.id)
      averages << ratings.average(:score)
    end

    (averages.sum / averages.length).round(1)
  end

  def highest_rated_movies(limit = 10)
    user_ids = User.pluck(:id)

    top_ratings = Rating.where(user_id: user_ids)
                        .group(:movie_id)
                        .order('SUM(score) DESC')
                        .limit(limit)
                        .sum(:score)

    top_movies = Movie.where(id: top_ratings.keys)

    top_movies.sort_by { |movie| -top_ratings[movie.id] }
  end

  def highest_rated_movies_with_scores(limit = 20)
    movies = highest_rated_movies(limit)
    matt = User.where(first_name: 'Matt').first
    reba = User.where(first_name: 'Rebecca').first
    movies.map do |movie|
      ratings = Rating.where(movie_id: movie.id, user_id: [matt.id, reba.id])
      scores = ratings.map { |rating| convert_to_letter_grade(rating) }
      OpenStruct.new(title: movie.title, matt_score: scores[0], reba_score: scores[1])
    end
  end

  def biggest_divergence
    user_ids = User.pluck(:id)
    movies = Movie.all

    biggest_divergence = nil
    biggest_divergence_score = 0

    movies.each do |movie|
      ratings = Rating.where(movie_id: movie.id, user_id: user_ids)
      next if ratings.length < 2

      scores = ratings.pluck(:score)
      divergence = scores.max - scores.min

      if divergence > biggest_divergence_score
        biggest_divergence = movie
        biggest_divergence_score = divergence
      end
    end

    biggest_divergence
  end
end
