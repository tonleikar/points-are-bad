class Match < ApplicationRecord
  has_many :predictions
  has_many :users, through: predictions
end
