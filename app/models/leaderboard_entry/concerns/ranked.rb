# frozen_string_literal: true

module LeaderboardEntry::Concerns
  module Ranked
    extend ActiveSupport::Concern

    included do
      before_save :drop_leaderboard_cache
    end

    module ClassMethods
      # kvokka it returns Hash, so it is not right to use ::scope here
      def ranked(leaderboard)
        Rails.cache.fetch("rank_#{leaderboard.id}") do
          where(leaderboard: leaderboard).group(:username).order("sum_score desc").sum(:score)
        end
      end
    end

    def save_with_rank(*args)
      rank_before = self.class.ranked leaderboard
      return false unless save(*args)

      rank_after = self.class.ranked leaderboard
      (rank_before.keys.index(username) || rank_after.size) - rank_after.keys.index(username)
    end

    private

    def drop_leaderboard_cache
      Rails.cache.delete("rank_#{leaderboard.id}")
    end
  end
end
