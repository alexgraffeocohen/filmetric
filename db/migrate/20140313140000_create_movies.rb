class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.integer :critics_score
      t.integer :audience_score
      t.string :critics_consensus
      t.string :poster_link
      t.string :rating
      t.string :rt_link

      t.timestamps
    end
  end
end
