class ChangeColumnsToTextOnMovies < ActiveRecord::Migration
  def up
    change_column :movies, :title, :text
    change_column :movies, :critics_consensus, :text
    change_column :movies, :poster_link, :text
    change_column :movies, :rating, :text
    change_column :movies, :rt_link, :text
  end

  def down
    change_column :movies, :title, :string
    change_column :movies, :critics_consensus, :string
    change_column :movies, :poster_link, :string
    change_column :movies, :rating, :string
    change_column :movies, :rt_link, :string
  end
end
