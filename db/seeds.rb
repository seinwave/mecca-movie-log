# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Movie.create(title: "Brave")
Movie.create(title: "Mandy")
Movie.create(title: "The Shining")
Movie.create(title: "The Thing")

User.create(first_name: "Matt", last_name: "Seidholz")
User.create(first_name: "Rebecca", last_name: "Brammer-Shlay")

Rating.create(watched_date: "2023-01-01", score: 5, user_id: 1, movie_id: 1)
Rating.create(watched_date: "2023-01-01", score: 5, user_id: 1, movie_id: 2)
Rating.create(watched_date: "2023-01-01", score: 5, user_id: 1, movie_id: 3)
Rating.create(watched_date: "2023-01-01", score: 5, user_id: 1, movie_id: 4)
Rating.create(watched_date: "2023-01-01", score: 5, user_id: 2, movie_id: 1)
Rating.create(watched_date: "2023-01-01", score: 5, user_id: 2, movie_id: 2)
Rating.create(watched_date: "2023-01-01", score: 5, user_id: 2, movie_id: 3)