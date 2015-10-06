class AddUserToSong < ActiveRecord::Migration
  def change
    add_reference :songs, :user, index: true, default: 1
  end
end
