class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :predicted_home_score, :predicted_away_score, presence: true
  validates :user_id, uniqueness: { scope: :match_id, message: "has already made a prediction for this match" }
end
