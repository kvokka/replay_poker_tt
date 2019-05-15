# frozen_string_literal: true

class Leaderboard < ApplicationRecord
  has_many :entries, class_name: "LeaderboardEntry", dependent: :destroy

  delegate :to_s, to: :name
end
