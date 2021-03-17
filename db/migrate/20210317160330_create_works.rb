class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.references :writer,    null: false
      t.string :name,          null: false
      t.string :pronunciation, null: false
      t.string :file_url,      null: false
      t.string :wikipedia_url, null: false

      t.timestamps
    end
  end
end
