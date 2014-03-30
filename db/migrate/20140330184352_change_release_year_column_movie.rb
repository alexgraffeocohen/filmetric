class ChangeReleaseYearColumnMovie < ActiveRecord::Migration
  def up
    rename_column :movies, :release_year, :release_date
    change_column :movies, :release_date, :text
  end

  def down
    change_column :movies, :release_date, :integer
    rename_column :movies, :release_date, :release_year
  end
end
