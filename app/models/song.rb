class Song < ActiveRecord::Base

  has_many :votes
  belongs_to :user

  validates :song_title, presence: true
  validates :author, presence: true

end