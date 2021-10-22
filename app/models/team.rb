class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :projects, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }

  def self.search(search) 
    if search.present? 
      team = Team.where('name LIKE ?', "%#{search}%")
    else
      Team.all
    end
  end

  def team_create_date
    created_at.strftime("%Y-%m-%d")
  end
end
