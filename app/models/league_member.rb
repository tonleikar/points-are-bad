class LeagueMember < ApplicationRecord
  belongs_to :user
  belongs_to :league

  # TODO User cannot join a league they are already in
end
