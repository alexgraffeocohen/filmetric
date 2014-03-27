class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :name
      t.integer :filmetric

      t.timestamps
    end
  end
end
