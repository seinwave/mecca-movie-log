require 'pg'
require 'csv'

# Establish a connection to the database
conn = PG.connect(dbname: 'your_database_name', user: 'your_username', password: 'your_password')

# Read the CSV file

# Close the connection
conn.close

def import_movies
  CSV.foreach('Mecca Movie Log - Sheet1.csv', headers: true) do |row|
    # Skip if the row is empty or the title is empty
    next if row['TITLE'].nil? || row['TITLE'].strip.empty?
  
    # Insert movie if it doesn't exist
    movie_title = row['TITLE']
    conn.exec_params('INSERT INTO movies (title) VALUES ($1) ON CONFLICT (title) DO NOTHING', [movie_title])
  end
end 

def im
  