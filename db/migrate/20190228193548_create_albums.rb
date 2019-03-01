class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :band_name, null: false
      t.integer :year, null: false
      t.boolean :live?, null: false
      t.timestamps


    end
    add_index :albums, :title
    add_index :albums, :year
  end
end
