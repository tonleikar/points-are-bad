# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear out existing data to prevent duplicate unique key errors on re-seeding
puts "Cleaning database..."
Prediction.destroy_all
LeagueMember.destroy_all
League.destroy_all
Match.destroy_all
User.destroy_all

puts "Creating users..."
# 1. Create your main test user for logging in
me = User.create!(
  username: "test_user",
  email: "test@example.com",
  password: "password123",       # Devise handles encrypted_password automatically
  password_confirmation: "password123",
  score: 45
)

# 2. Create pool of alternative users to populate leagues and leaderboards
other_users = []
usernames = %w[footy_fanatic goal_getter tactical_genius offside_expert var_hater pitch_perfect]

usernames.each_with_index do |name, index|
  other_users << User.create!(
    username: name,
    email: "#{name}@example.com",
    password: "password123",
    password_confirmation: "password123",
    score: rand(50)
  )
end
all_users = [ me ] + other_users

puts "Creating leagues..."
# 3. Create leagues (Handles creator_id and auto-generates join_codes via your model callbacks)
public_league = League.create!(name: "Global Pub League", creator: me)
work_league = League.create!(name: "Office Bragging Rights", creator: other_users.first)
friends_league = League.create!(name: "The Weekend Warriors", creator: other_users.last)

# 4. Fill league memberships
# Put everyone in the Global Pub League
all_users.each do |user|
  LeagueMember.create!(user: user, league: public_league)
end

# Put a subset of users in the other leagues
other_users.sample(3).each { |u| LeagueMember.create!(user: u, league: work_league) }
LeagueMember.create!(user: me, league: work_league) # Make sure you're in this one too

other_users.sample(4).each { |u| LeagueMember.create!(user: u, league: friends_league) }


puts "Creating matches..."
# 5. Finished Matches (Great for testing how your UI handles results and past predictions)
past_matches = [
  { home_team: "Arsenal", away_team: "Chelsea", home_score: 2, away_score: 1 },
  { home_team: "Real Madrid", away_team: "Barcelona", home_score: 3, away_score: 3 },
  { home_team: "Wolves", away_team: "PSG", home_score: 3, away_score: 1 },
  { home_team: "Liverpool", away_team: "Man City", home_score: 0, away_score: 2 }
]

finished_matches = past_matches.map do |m|
  Match.create!(
    home_team: m[:home_team],
    away_team: m[:away_team],
    home_score: m[:home_score],
    away_score: m[:away_score],
    finished: true,
    kickoff: 2.days.ago
  )
end

# 6. Future Matches (Great for testing forms where users input upcoming predictions)
future_matches = [
  { home_team: "Man United", away_team: "Tottenham", kickoff: 1.day.from_now },
  { home_team: "Bayern Munich", away_team: "Dortmund", kickoff: 2.days.from_now },
  { home_team: "PSG", away_team: "Marseille", kickoff: 3.days.from_now },
  { home_team: "Juventus", away_team: "AC Milan", kickoff: 5.days.from_now }
]

upcoming_matches = future_matches.map do |m|
  Match.create!(
    home_team: m[:home_team],
    away_team: m[:away_team],
    home_score: nil,
    away_score: nil,
    finished: false,
    kickoff: m[:kickoff]
  )
end


puts "Creating predictions..."
# 7. Generate random historic predictions for finished games to check layout
finished_matches.each do |match|
  all_users.each do |user|
    Prediction.create!(
      user: user,
      match: match,
      home_prediction: rand(0..3),
      away_prediction: rand(0..3),
      points_earned: [ 0, 1, 3 ].sample # Typical prediction systems grant 0, 1, or 3 points
    )
  end
end

# 8. Generate some existing upcoming predictions for the logged-in user
# This lets you test the difference between empty forms and "Edit prediction" layouts
Prediction.create!(
  user: me,
  match: upcoming_matches.first,
  home_prediction: 2,
  away_prediction: 0,
  points_earned: nil
)

Prediction.create!(
  user: me,
  match: upcoming_matches.second,
  home_prediction: 1,
  away_prediction: 1,
  points_earned: nil
)

puts "--- Database Seeded Successfully! ---"
puts "Log-in User Email:    test@example.com"
puts "Log-in User Password: password123"
puts "Leagues Generated:    #{League.count}"
puts "Matches Generated:    #{Match.count}"
puts 'Seed complete'
