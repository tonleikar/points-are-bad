# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
sample_users = [
  { email: "debbie@points.com", username: "debbie" },
  { email: "miles@points.com", username: "miles" },
  { email: "joan@points.com", username: "joan" },
  { email: "prince@points.com", username: "prince" },
  { email: "sade@points.com", username: "sade" },
  { email: "bjork@points.com", username: "bjork" }
]

sample_users.each do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |user|
    user.password = "password123"
    user.password_confirmation = "password123"
    user.username = attrs[:username]
  end
end
