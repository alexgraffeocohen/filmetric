# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

the_departed = Movie.new(

                :title => "The Departed",
         :release_date => '2006-10-12',
            :filmetric => -2,
        :critics_score => 92,
       :audience_score => 94,
    :critics_consensus => "Featuring outstanding work from an excellent cast that includes Jack Nicholson, Leonardo DiCaprio, and Matt Damon, The Departed is a thoroughly engrossing gangster drama with the gritty authenticity and soupy morality that has infused director Martin Scorsese's past triumphs.",
          :poster_link => "http://content7.flixster.com/movie/11/16/67/11166721_ori.jpg",
               :rating => "R",
              :rt_link => "http://www.rottentomatoes.com/m/departed/"
)

the_departed.directors << Director.new(name: "Martin Scorsese", filmetric: 1)
drama = Genre.new(name: "Drama", filmetric: -5)
action_adventure = Genre.new(name: "Action & Adventure", filmetric: -6)
mystery_suspense = Genre.new(name: "Mystery & Suspense", filmetric: -4)
the_departed.genres << drama << action_adventure << mystery_suspense
the_departed.actors << [Actor.new(name: "Leonardo DiCaprio", filmetric: -6), Actor.new(name: "Matt Damon", filmetric: 1), Actor.new(name: "Jack Nicholson", filmetric: -5), Actor.new(name: "Mark Wahlberg", filmetric: -4), Actor.new(name: "Martin Sheen", filmetric: 1)]

the_departed.save


