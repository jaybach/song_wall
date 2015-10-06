class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_title
      t.string :author
      t.string :url
      t.timestamps
      t.integer :votes, default: 0
    end
  end
end
