class CreateWriters < ActiveRecord::Migration[6.1]
  def change
    create_table :writers do |t|
      t.string :name,          null: false
      t.string :pronunciation, null: false
      t.string :romaji,        null: false
      t.date   :born_at,       null: false
      t.date   :dead_at,       null: true
      t.string :summary,       null: false
      t.string :wikipedia_url, null: false

      t.timestamps
    end
  end
end
