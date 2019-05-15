# frozen_string_literal: true

require "rails_helper"

RSpec.describe "LeaderboardEntries", type: :request do
  let(:subject) { create :leaderboard_entry }
  let(:leaderboard) { create :leaderboard }

  describe "GET /leaderboard_entries" do
    it "works! (now write some real specs)" do
      get leaderboard_entries_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /leaderboard_entries" do
    it "return status 200 and create new entry" do
      post leaderboard_entries_path,
           params: { leaderboard_entry: attributes_for(:leaderboard_entry, leaderboard_id: leaderboard.id) }

      expect(response).to redirect_to(leaderboard)
      expect(LeaderboardEntry.count).to eq 1
    end

    context "with entries" do
      before do
        10.times { |n| create :leaderboard_entry, leaderboard: leaderboard, score: n, username: "user_#{n % 3}" }
      end

      it "show correct flash message" do
        post leaderboard_entries_path,
             params: { leaderboard_entry: { username: "user_1", score: 10, leaderboard_id: leaderboard.id } }

        expect(flash[:notice]).to match "user_1 rank changed by 2"
      end
    end
  end
end
