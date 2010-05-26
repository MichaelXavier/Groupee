class Meeting < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :from, :allow_nil => false
  validates_presence_of :to, :allow_nil => false
  validates_with DurationValidator, :from => :from, :to => :to

  has_many :agenda_items, :dependent => :destroy
  has_and_belongs_to_many :attendees, :class_name => "User"

  #FIXME: spec me
  def sign_in_attendee(attendee)
   raise ArgumentError, "User is not on the list of attendees" unless attendees.include? attendee 
   return nil if attendee_exists? attendee
    sign_in_attendee_hook(attendee)
  end

  def attendee_exists?(attendee)
    begin
      self.attendees.find(attendee.id)
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end
private
  def sign_in_attendee_hook(user)
    link_type = LinkType.meeting_attendee
    self.attendees.each do |attendee|
      next if attendee == user
      Link.create!(
        :left_user => member, 
        :right_user => user, 
        :link_type => link_type,
        :context => self
      )
    end
  end

end
