class Meeting < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :from, :allow_nil => false
  validates_presence_of :to, :allow_nil => false
  validates_with DurationValidator, :from => :from, :to => :to

  has_many :agenda_items, :dependent => :destroy
  has_and_belongs_to_many :attendees, :class_name => "User"
end
