# frozen_string_literal: true

require 'csv'
require_relative '../config/environment'

MONTH_NAMES = %w[January February March April May June July August September October
                 November December].freeze
YEARS_IN_RANGE = 2019..2020

def is_valid_title?(title)
  title && !title.strip.empty? && title.strip != 'TITLE' && !is_a_case_insensitive_month?(title) && !is_a_year?(title)
end

def is_a_case_insensitive_month?(title)
  MONTH_NAMES.include?(title.strip.capitalize)
end

def is_a_year?(title)
  YEARS_IN_RANGE.include?(title.strip.to_i)
end

def import_movies(file_path)
  file_path = File.expand_path(file_path)

  puts "importing movies from #{file_path}!"
  CSV.foreach(file_path, headers: true) do |row|
    # Skip if the row is empty or the title is empty
    puts 'ROW!', row['TITLE']
    next unless is_valid_title?(row['TITLE'])

    puts "importing #{row['TITLE']}"

    # Insert movie if it doesn't exist
    movie_title = row['TITLE']
    Movie.find_or_create_by(title: movie_title)
  end
end

LETTER_GRADES = {
  'A+' => 15,
  'A' => 14,
  'A-' => 13,
  'B+' => 12,
  'B' => 11,
  'B-' => 10,
  'C+' => 9,
  'C' => 8,
  'C-' => 7,
  'D+' => 6,
  'D' => 5,
  'D-' => 4,
  'F+' => 3,
  'F' => 2,
  'F-' => 1,
  'Fart Minus' => -2000
}.freeze

class MovieImporter
  def initialize
    @current_month = nil
    @current_year = nil
  end

  def import_data(file_path)
    import_movies(file_path)
    import_ratings(file_path)
  end

  def import_movies(file_path)
  file_path = File.expand_path(file_path)

  puts "importing movies from #{file_path}!"
  CSV.foreach(file_path, headers: true) do |row|
    # Skip if the row is empty or the title is empty
    puts 'ROW!', row['TITLE']
    next unless is_valid_title?(row['TITLE'])

    puts "importing #{row['TITLE']}"

    # Insert movie if it doesn't exist
    movie_title = row['TITLE']
    Movie.find_or_create_by(title: movie_title)
  end
end

  def has_existing_rating?(user_id, movie_id)
    Rating.find_by(user_id:, movie_id:)
  end

  def import_ratings(file_path)
    file_path = File.expand_path(file_path)
    # get year from file_path
    @current_year = file_path.split('/')[-1].split('.')[0].to_i

    puts "importing ratings from #{file_path}!"
    CSV.foreach(file_path, headers: true) do |row|
      # Skip if the row is empty or the title is empty
      # capture month

      next if row['TITLE'].nil? || row['TITLE'].strip.empty?

      @current_month = row['TITLE'].strip.capitalize if is_a_case_insensitive_month?(row['TITLE'])

      next unless is_valid_title?(row['TITLE'])

      puts "importing #{row['TITLE']}"

      # Insert movie if it doesn't exist
      movie_title = row['TITLE']
      movie = Movie.find_by(title: movie_title)
      unless movie
        puts "movie not found for #{movie_title}"
        next
      end

      # parse date from DATE entry
      date = row['DATE']

      if date
        puts "DATE: #{date}"
        date = Date.strptime("#{@current_year}/#{date}", '%Y/%m/%d')
      else
        # assign date to a random date in the month
        puts "no date found for #{movie_title} in #{@current_month}"
        date = Date.new(@current_year, MONTH_NAMES.index(@current_month) + 1, rand(1..28))
      end

      # create a rating for Reba, user_id: 1
      reba_score = LETTER_GRADES[row['REBA']]
      puts 'creating rating for Reba'
      reba = User.where(first_name: 'Rebecca').first
      puts 'reba:', reba
      reba_rating = Rating.new(user_id: reba.id, movie_id: movie.id, watched_date: date, score: reba_score)
      unless reba_rating.valid?
        puts 'reba_rating is invalid'
        next
      end
      reba_rating.save

      # create a rating for Matt, user_id: 2
      matt_score = LETTER_GRADES[row['MATT']]
      puts 'creating rating for Matt'
      matt = User.where(first_name: 'Matt').first
      matt_rating = Rating.new(user_id: matt.id, movie_id: movie.id, watched_date: date, score: matt_score)
      unless matt_rating.valid?
        puts 'matt_rating is invalid'
        next
      end
      matt_rating.save
    end
  end
end

def import_all_years(dir_path)
  Dir.foreach(dir_path) do |file_name|
    puts "file_name: #{file_name}"
    next if ['.', '..'].include?(file_name)

    year = file_name.split('.')[0].to_i
    puts "year: #{year}"
    import_ratings("#{dir_path}/#{file_name}", year)
  end
end

importer = MovieImporter.new

importer.import_data(ARGV[0])
