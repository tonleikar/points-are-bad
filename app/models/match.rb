class Match < ApplicationRecord
  has_many :predictions
  has_many :users, through: predictions

  # TODO create matches through a service or rake. Perhaps they are generated at the start of a season / tournament.
end
