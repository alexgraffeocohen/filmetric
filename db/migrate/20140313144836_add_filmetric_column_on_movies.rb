class AddFilmetricColumnOnMovies < ActiveRecord::Migration
  def change
    add_column :movies, :filmetric, :integer
  end
end
