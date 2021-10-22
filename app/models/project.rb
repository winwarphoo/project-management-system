class Project < ApplicationRecord
  belongs_to :team
  validates :name, presence: true, length: { maximum: 100 }
  validates :start_date, date: { before: :end_date }
  validates :end_date, date: { after: :start_date }

  def self.search(search) 
    if search.present? 
      project = Project.where('name LIKE ?', "%#{search}%")
    else
      Project.all
    end
  end

end
