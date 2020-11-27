# Add seed data here. Seed your database with `rake db:seed`

Song.create(name: "Gasoline Dreams", artist_id: 18)
Song.create(name: "I'm Cool", artist_id: 18)
Song.create(name: "So Fresh So Clean", artist_id: 18)
Song.create(name: "Ms Jackson", artist_id: 18)
Song.create(name: "Snappin & Trappin", artist_id: 18)
Song.create(name: "Spaghetti Junction", artist_id: 18)


Artist.create(name: "Outkast")
Artist.create(name: "Katy Perry")
Artist.create(name: "Jedi Mind Tricks")
Artist.create(name: "Mystikal")

Genre.create(name: "pop")
Genre.create(name: "rap")

Song.all.each do |song|
    song.artist = Artist.find_by(name: "Outkast")
end