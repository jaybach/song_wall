class CreateUpvoteTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :song, index: true
      t.belongs_to :user, index: true
      t.integer :total, default: 0
    end
  end
end
