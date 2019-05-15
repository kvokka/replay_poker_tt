# frozen_string_literal: true

FactoryBot.define do
  factory :leaderboard_entry do
    leaderboard
    sequence(:username) { |n| "username_#{n}" }
    score               { 10 }
  end
end
