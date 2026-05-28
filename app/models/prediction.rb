class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :home_prediction, :away_prediction, presence: true
  validates :user_id, uniqueness: { scope: :match_id, message: "has already made a prediction for this match" }

  # TODO Prediction cannot be 1 - 1. Could be done in the controller.
end
