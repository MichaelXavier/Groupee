class Assignment < ActiveRecord::Base
  validates_presence_of :name, :allow_nil => false
  validates_numericality_of :user_limit
  validates_with DurationValidator, :from => :assigned, :to => :due

  belongs_to :course
  has_many :groups

  # Called when the assignment is due to automatically dissolve any groups
  # formed under this assignment.
  def dissolve_groups
    groups.destroy_all
  end

  def expired?
    due and Time.now > due
  end

  def in_progress?
    assigned and due and (assigned..due).include? Time.now
  end
end
