class Leaderboard < ApplicationRecord
  has_many :entries, class_name: 'LeaderboardEntry'

  delegate :to_s, to: :name
end
