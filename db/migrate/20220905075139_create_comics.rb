class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|

      t.integer :customer_id
      t.integer :company_id
      t.string :title, null: false
      t.text :body, null: false
      t.string :name, null: false
      t.date :release_date, null: false
      t.float :star

      t.timestamps
    end
  end
end
