class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.references :writer,    null: false
      t.string :name,          null: false, default: ''
      t.string :pronunciation, null: false, default: ''
      t.string :file_url,      null: false, default: ''
      t.string :wikipedia_url, null: false, default: ''

      t.timestamps
    end
  end
end
