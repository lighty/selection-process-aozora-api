class CreateWriters < ActiveRecord::Migration[6.1]
  def change
    create_table :writers do |t|
      t.string :name,          null: false, default: ''
      t.string :pronunciation, null: false, default: ''
      t.string :romaji,        null: false, default: ''
      t.date   :born_at
      t.date   :dead_at
      t.string :summary,       null: false, default: ''
      t.string :wikipedia_url, null: false, default: ''

      t.timestamps
    end
  end
end
