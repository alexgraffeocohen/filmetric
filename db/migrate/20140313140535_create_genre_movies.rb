class CreateGenreMovies < ActiveRecord::Migration
  def change
    create_table :genre_movies do |t|
      t.integer :genre_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
