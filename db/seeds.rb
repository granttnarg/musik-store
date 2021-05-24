# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Clear DB
puts "Cleaning DB..."
User.destroy_all
Record.destroy_all
Artist.destroy_all

system_user = User.new(username:"system_user", email: "sytstem_user@musikstore.de")
system_user.password = "qwerty"
system_user.save!
puts "creating 1 user ..."

eddie = Artist.create!(name: "Eddie Murphy", favourite_count: 10, bio: "Edward Regan Murphy is an American actor, comedian, writer, producer, and singer. He rose to fame on the sketch comedy show Saturday Night Live, for which he was a regular cast member from 1980 to 1984.")
aphex_twin = Artist.create!(name: "Aphex Twin", favourite_count: 99, bio: "Richard David James (born 18 August 1971), best known by the stage name Aphex Twin, is a British musician, composer and DJ.[1] He is best known for his idiosyncratic work in electronic styles such as techno and ambient music in the 1990s, and has also been associated with the electronic subgenre known as intelligent dance music (IDM), although James has dismissed this label.[2] In 2001, Guardian journalist Paul Lester called James 'the most inventive and influential figure in contemporary electronic music.'")
puts "creating 2 artists ..."

record_one = Record.create!(title: "Party all the time", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie)
record_two = Record.create!(title: "Avril 14th", description: "Minimal Piano track with a nod to Erik Satie", genre: "classical", album: "drukqs", artwork_url: "", like_count: 998, artist: aphex_twin)
puts "creating 2 records ..."

puts "seeding successful."