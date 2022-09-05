class CreateComicGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_genres do |t|

      t.integer :comic_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
