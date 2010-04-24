class Assignment < ActiveRecord::Base
  validates_presence_of :name, :allow_nil => false
  validates_numericality_of :user_limit, :greater_than => 0
  validates_with DurationValidator, :from => :assigned, :to => :due

  belongs_to :course
  has_many :groups

  # Called when the assignment is due to automatically dissolve any groups
  # formed under this assignment.
  def dissolve_groups
    groups.destroy_all
  end
end
