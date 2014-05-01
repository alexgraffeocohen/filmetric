require 'spec_helper'

FactoryGirl.define do
  factory :movie do
    id { Faker::Number.number(5) }
    title { Faker::Lorem.word }
    release_date { "Fri, 10 Jan 2014" }
    critics_score { Faker::Number.number(2).to_i }
    audience_score { Faker::Number.number(2).to_i }
    critics_consensus { Faker::Lorem.sentence }
    poster_link { 'http://content9.flixster.com/movie/11/17/28/11172839_ori.jpg' }
    rating { 'R' }
  end
end
