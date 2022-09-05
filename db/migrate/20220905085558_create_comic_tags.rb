class CreateComicTags < ActiveRecord::Migration[6.1]
  def change
    create_table :comic_tags do |t|

      t.integer :comic_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
