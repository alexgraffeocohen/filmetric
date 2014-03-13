class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.integer :filmetric

      t.timestamps
    end
  end
end
