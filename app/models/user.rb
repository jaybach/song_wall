class User < ActiveRecord::Base

  has_many :votes
  has_many :songs

  validates :name, presence: true, uniqueness: true 
  validates :email, presence: true, uniqueness: true, on:
  :create, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "this is not a
  valid email address"}

  validates :password, presence: true

end