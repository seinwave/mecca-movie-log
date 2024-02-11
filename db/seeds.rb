# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot'

Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

matt = FactoryBot.create(:user, first_name: 'Matt', last_name: 'Seidholz')
reba = FactoryBot.create(:user, first_name: 'Rebecca', last_name: 'Brammer-Shlay')

orphaned_movie = FactoryBot.create(:movie, title: 'Saltburn')
doubled_movie = FactoryBot.create(:movie, title: 'Die Hard')

# we watch multiple movies sometimes
2.times { FactoryBot.create(:rating, movie_id: doubled_movie.id, user_id: matt.id) }
2.times { FactoryBot.create(:rating, movie_id: doubled_movie.id, user_id: reba.id) }

# we watch movies alone sometimes
1.time { FactoryBot.create(:rating, user_id: reba.id, movie_id: orphaned_movie.id) }

# most of the time, we watch movies together
10.times do |n|
  FactoryBot.create(:ratings, user_id: reba_id, movie_id: n + 1)
end

10.times do |n|
  FactoryBot.create(:ratings, user_id: matt_id, movie_id: n + 1)
end
