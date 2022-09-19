class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|

      t.integer :customer_id
      t.string :company, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :name, null: false
      t.date :release_date, null: false
      t.float :star
      t.integer :status, default: 0,null: false

      t.timestamps
    end
  end
end
