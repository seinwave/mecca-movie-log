# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot'

matt = FactoryBot.create(:user, first_name: 'Matt', last_name: 'Seidholz')
reba = FactoryBot.create(:user, first_name: 'Rebecca', last_name: 'Brammer-Shlay')

orphaned_movie = FactoryBot.create(:movie, title: 'Saltburn')
doubled_movie = FactoryBot.create(:movie, title: 'Die Hard')

# somtimes, we watch movies multiple times
2.times { FactoryBot.create(:rating, movie_id: doubled_movie.id, user_id: matt.id, watched_date: '2024-01-10') }
2.times { FactoryBot.create(:rating, movie_id: doubled_movie.id, user_id: reba.id, watched_date: '2024-01-10') }

# we watch movies alone sometimes
FactoryBot.create(:rating, user_id: reba.id, movie_id: orphaned_movie.id) 

# most of the time, we watch movies together
together_movies = FactoryBot.create_list(:movie, 10)

together_movies.each_with_index do |movie, n|
  FactoryBot.create(:rating, user_id: reba.id, movie_id: movie.id, watched_date: "2024-01-#{11 + n}")
end

together_movies.each_with_index do |movie, n|
  FactoryBot.create(:rating, user_id: reba.id, movie_id: movie.id, watched_date: "2024-01-#{11 + n}")
end
