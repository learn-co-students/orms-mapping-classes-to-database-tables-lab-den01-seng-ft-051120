require 'bundler'
Bundler.require

require_relative '../lib/student'
#below code sets up a data for students in a public school district in SQL
DB = {:conn => SQLite3::Database.new("db/students.db")}
#refer to database with the command DB[:conn]