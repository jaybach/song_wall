class AddVotesTableToSongs < ActiveRecord::Migration
  def change
    add_reference :songs, :votes, index: true
  end
end
