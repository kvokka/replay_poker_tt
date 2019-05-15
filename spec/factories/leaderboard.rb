# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard do
    sequence(:name) { |n| "leaderboard_#{n}" }
  end
end
