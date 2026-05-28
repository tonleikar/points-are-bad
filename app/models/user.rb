class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :created_leagues, class_name: "League", foreign_key: "creator_id", dependent: :destroy
  has_many :league_members, dependent: :destroy
  has_many :leagues, through: :league_members
  has_many :predictions, dependent: :destroy
end
