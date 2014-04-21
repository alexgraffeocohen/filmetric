class ChangeReleaseDateType < ActiveRecord::Migration
  def up

    execute %q(
      ALTER TABLE movies 
      ALTER COLUMN release_date TYPE date USING ("release_date"::date);
      )

  end

  def down
    change_column :movies, :release_date, :text
  end
end
