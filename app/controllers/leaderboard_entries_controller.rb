# frozen_string_literal: true

class LeaderboardEntriesController < ApplicationController
  before_action :set_leaderboard_entry, only: %i[show edit update destroy]

  # GET /leaderboard_entries
  def index
    @leaderboard_entries = LeaderboardEntry.includes(:leaderboard)
  end

  # GET /leaderboard_entries/1
  def show; end

  # GET /leaderboard_entries/new
  def new
    @leaderboard_entry = LeaderboardEntry.new
  end

  # GET /leaderboard_entries/1/edit
  def edit; end

  # POST /leaderboard_entries
  def create
    @leaderboard_entry = LeaderboardEntry.new(leaderboard_entry_params)
    rank_delta = @leaderboard_entry.save_with_rank
    return render(:new) unless rank_delta

    message = "Score added. #{leaderboard_entry_params[:username]} rank changed by #{rank_delta}"
    redirect_to @leaderboard_entry.leaderboard, notice: message
  end

  # PATCH/PUT /leaderboard_entries/1
  def update
    if @leaderboard_entry.update(leaderboard_entry_params)
      redirect_to @leaderboard_entry, notice: "Leaderboard entry was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /leaderboard_entries/1
  def destroy
    @leaderboard_entry.destroy
    redirect_to leaderboard_entries_url, notice: "Leaderboard entry was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_leaderboard_entry
    @leaderboard_entry = LeaderboardEntry.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def leaderboard_entry_params
    params.require(:leaderboard_entry).permit(:leaderboard_id, :username, :score)
  end
end
