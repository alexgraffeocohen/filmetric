require 'faker'

FactoryGirl.define do
  factory :movie do
    id { Faker::Number.number(5) }
    title { Faker::Lorem.word }
    release_date { "Fri, 10 Jan 2014" }
    critics_score { Faker::Number.number(2).to_i }
    audience_score { Faker::Number.number(2).to_i }
    filmetric { critics_score - audience_score }
    critics_consensus { Faker::Lorem.sentence }
    poster_link { "http://content6.flixster.com/movie/11/16/80/11168096_ori.jpg" }
    rating { 'R' }

    factory :movie_critics_like_more do
      critics_score 95
      audience_score 90
    end
  end
end
