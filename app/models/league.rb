class League < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :name, presence: true

  before_create :generate_join_code

  private

  def generate_join_code
    self.join_code = SecureRandom.alphanumeric(8).upcase
  end
end
