module LeaderboardEntry::Concerns
  module Ranked
    extend ActiveSupport::Concern

    included do
      before_save :drop_leaderboard_cache
    end

    module ClassMethods
      #kvokka it returns Hash, so it is not right to use ::scope here
      def ranked(leaderboard)
        Rails.cache.fetch("rank_#{leaderboard.id}") do
          where(leaderboard: leaderboard).group(:username).order('sum_score desc').sum(:score)
        end
      end
    end

    private

    def drop_leaderboard_cache
      Rails.cache.delete("rank_#{leaderboard.id}")
    end
  end
end