class LinkType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :weight, 
                            :greater_than_or_equal_to => 0.0, 
                            :less_than_or_equal_to => 1.0,
                            :allow_nil => false

  has_many :links

  def self.group_member
    where(:name => 'GroupMember').limit(1).first
  end

  def self.classmate
    where(:name => 'Classmate').limit(1).first
  end

  def self.meeting_attendee
    where(:name => 'MeetingAttendee').limit(1).first
  end

  def self.setup_defaults
    LinkType.find_or_create_by_name(
      :name => "GroupMember",
      :weight => 0.8
    )

    LinkType.find_or_create_by_name(
      :name => "Classmate",
      :weight => 0.4
    )

    LinkType.find_or_create_by_name(
      :name => "MeetingAttendee",
      :weight => 0.1
    )
  end
end
