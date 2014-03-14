# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140313144836) do

  create_table "actor_movies", force: true do |t|
    t.integer "actor_id"
    t.integer "movie_id"
  end

  create_table "actors", force: true do |t|
    t.string  "name"
    t.integer "filmetric"
  end

  create_table "director_movies", force: true do |t|
    t.integer "director_id"
    t.integer "movie_id"
  end

  create_table "directors", force: true do |t|
    t.string  "name"
    t.integer "filmetric"
  end

  create_table "genre_movies", force: true do |t|
    t.integer "movie_id"
    t.integer "genre_id"
  end

  create_table "genres", force: true do |t|
    t.string  "name"
    t.integer "filmetric"
  end

  create_table "movies", force: true do |t|
    t.string  "title"
    t.integer "release_year"
    t.integer "critics_score"
    t.integer "audience_score"
    t.string  "critics_consensus"
    t.string  "poster_link"
    t.string  "rating"
    t.string  "rt_link"
    t.integer "filmetric"
  end

end
