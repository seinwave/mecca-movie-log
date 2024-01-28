require 'csv'
require_relative '../config/environment'

MONTH_NAMES = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
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
    next if !is_valid_title?(row['TITLE'])

    puts "importing #{row['TITLE']}"
    
    # Insert movie if it doesn't exist
    movie_title = row['TITLE']
    Movie.find_or_create_by(title: movie_title)
  end
end


LETTER_GRADES = {
'A+' => 15,
'A'  => 14,
'A-' => 13,
'B+' => 12,
'B'  => 11,
'B-' => 10,
'C+' => 9,
'C'  => 8,
'C-' => 7,
'D+' => 6,
'D'  => 5,
'D-' => 4,
'F+' => 3,
'F'  => 2,
'F-' => 1
'Fart Minus' => -2000
}

def import_ratings(file_path, year)
  file_path = File.expand_path(file_path)
  puts "importing ratings from #{file_path}!"
  CSV.foreach(file_path, headers: true) do |row|
    # Skip if the row is empty or the title is empty
    next if !is_valid_title?(row['TITLE'])

    puts "importing #{row['TITLE']}"

    # Insert movie if it doesn't exist
    movie_title = row['TITLE']
    movie = Movie.find_by(title: movie_title)
    if !movie
      puts "movie not found for #{movie_title}"
      next
    end

    # parse date from DATE entry
    date = row['DATE']
    date = Date.strptime(row['DATE'], '%m/%d/%Y')
   
    # create a rating for Reba, user_id: 1
    reba_score = LETTER_GRADES[row['REBA']]
    reba_rating = Rating.new(user_id: 1, movie_id: movie.id, watched_date: date, score: reba_score)
    reba_rating.save

    # create a rating for Matt, user_id: 2
    matt_score = LETTER_GRADES[row['MATT']]
    matt_rating = Rating.new(user_id: 2, movie_id: movie.id, watched_date: date, score: matt_score)
    matt_rating.save
  end
end


def import_all_years(dir_path)
  # for each file in the dir path
  # open it, and import the ratings according to the YEAR which is in the file name
  # e.g. 2019.csv, 2020.csv
  Dir.foreach(dir_path) do |file_name|
    next if file_name == '.' || file_name == '..'
    year = file_name.split('.')[0].to_i
    puts "year: #{year}"
    import_ratings("#{dir_path}/#{file_name}", year)
  end

end 

  