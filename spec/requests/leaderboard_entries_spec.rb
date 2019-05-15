require 'rails_helper'

RSpec.describe "LeaderboardEntries", type: :request do
  let(:subject) { create :leaderboard_entry }
  let(:leaderboard) { create :leaderboard }

  describe "GET /leaderboard_entries" do
    it "works! (now write some real specs)" do
      get leaderboard_entries_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /leaderboard_entries" do
    it "return status 200 and create new entry" do
      post leaderboard_entries_path,
           params: { leaderboard_entry: attributes_for(:leaderboard_entry, leaderboard_id: leaderboard.id) }

      expect(response).to redirect_to(leaderboard)
      expect(LeaderboardEntry.count).to eq 1
    end
  end
end
