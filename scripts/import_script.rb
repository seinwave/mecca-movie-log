require 'csv'
require_relative 'config/environment'

def import_movies(file_path)
  file_path = File.expand_path(file_path)

  puts "importing movies from #{file_path}!"
  CSV.foreach(file_path, headers: true) do |row|
    # Skip if the row is empty or the title is empty
    puts 'ROW!', row['TITLE']
    next if row['TITLE'].nil? || row['TITLE'].strip.empty?

    puts "importing #{row['TITLE']}"
    
    # Insert movie if it doesn't exist
    movie_title = row['TITLE']
    Movie.find_or_create_by(title: movie_title)
  end
end




import_movies(ARGV[0]) 
  