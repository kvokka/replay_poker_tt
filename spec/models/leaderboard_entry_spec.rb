# frozen_string_literal: true

require "rails_helper"

RSpec.describe LeaderboardEntry, type: :model do
  let(:leaderboard)  { create :leaderboard }
  let(:leaderboard2) { create :leaderboard }

  describe "scopes" do
    describe "ranked" do
      before do
        10.times { |n| create :leaderboard_entry, leaderboard: leaderboard, score: n, username: "user_#{n % 3}" }
        3.times { |n| create :leaderboard_entry, leaderboard: leaderboard2, score: n * 10, username: "user_#{n % 3}" }
      end

      it "return leaderboard ordered by score sum and use only right values" do
        result = LeaderboardEntry.ranked(leaderboard)
        expect(result).to eq("user_0" => 18, "user_2" => 15, "user_1" => 12)
      end

      it "return leaderboard2 ordered by score sum and use only right values" do
        result = LeaderboardEntry.ranked(leaderboard2)
        expect(result).to eq("user_2" => 20, "user_1" => 10, "user_0" => 0)
      end
    end
  end
end
