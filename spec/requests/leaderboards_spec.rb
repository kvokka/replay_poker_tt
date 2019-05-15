# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Leaderboards", type: :request do
  let(:subject) { create :leaderboard }

  describe "GET /leaderboards" do
    it "works! (now write some real specs)" do
      get leaderboards_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /leaderboard/:id" do
    it "return status 200" do
      get leaderboard_path subject
      expect(response).to have_http_status(:ok)
    end

    context "with entries" do
      before do
        10.times { |n| create :leaderboard_entry, leaderboard: subject, score: n, username: "user_#{n % 3}" }
      end

      it "return page with correct ranks" do
        get leaderboard_path subject
        expect(body).to match("user_0 - 18")
        expect(body).to match("user_1 - 12")
        expect(body).to match("user_2 - 15")
      end
    end
  end
end
