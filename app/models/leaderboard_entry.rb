class LeaderboardEntry < ApplicationRecord
  include Concerns::Ranked
  belongs_to :leaderboard
end
