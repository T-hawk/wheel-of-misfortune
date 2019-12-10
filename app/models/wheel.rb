class Wheel < ApplicationRecord
  has_many :active_games
  has_many :finished_games
end
