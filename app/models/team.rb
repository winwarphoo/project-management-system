class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :projects, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }

  def team_create_date
    created_at.strftime("%Y-%m-%d")
  end
  def name_with_initial
    "#{name}"
  end
end
