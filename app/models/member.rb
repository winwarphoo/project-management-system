class Member < ApplicationRecord
  belongs_to :team
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 30 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
