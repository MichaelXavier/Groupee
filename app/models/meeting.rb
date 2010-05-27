class Meeting < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :from, :allow_nil => false
  validates_presence_of :to, :allow_nil => false
  validates_with DurationValidator, :from => :from, :to => :to

  has_many :agenda_items, :dependent => :destroy
  has_and_belongs_to_many :attendees, :class_name => "User"

  # All this method does is call the hook unless the user is not on the list of
  # attendees. There is no list of users who actually attended so there is
  # nothing to check against. That means the hook could get called multiple
  # times which is potentially a problem.
  def sign_in_attendee(attendee)
    raise ArgumentError, "User is not on the list of attendees" unless attendees.include? attendee 
    sign_in_attendee_hook(attendee)
    attendee
  end

  def attendee_exists?(attendee)
    begin
      self.attendees.find(attendee.id)
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end

  def add_attendee(attendee)
    return nil if attendee_exists? attendee
    self.attendees << attendee
    self.save#FIXME: is this necessary? i always forget
    add_attendee_hook(attendee)
    attendee
  end
private
  def sign_in_attendee_hook(user)
    link_type = LinkType.meeting_attendee
    self.attendees.each do |attendee|
      next if attendee == user
      Link.create!(
        :left_user => user, 
        :right_user => attendee, 
        :link_type => link_type,
        :context => self
      )
    end
  end

  def add_attendee_hook(user)
    # Add whatever you want done here
  end

end
