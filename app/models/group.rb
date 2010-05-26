class GroupFullError < RuntimeError; end
class Group < ActiveRecord::Base
  VALID_STATUSES = %w[ active suspended closed ]
  validates_inclusion_of :open, :in => [true,false]
  validates_presence_of :name
  validates_numericality_of :user_limit, :greater_than => 0
  validates_inclusion_of :status,        :in => VALID_STATUSES
  validates_format_of :website,          :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, 
                                         :allow_blank => true, 
                                         :allow_nil => true
  has_many :group_memberships
  has_many :users, :through => :group_memberships
  has_many :links, :as => :context
  # Availabilities for the group indicates optimal meeting times
  has_and_belongs_to_many :availabilities

  # Optional relationship for a group being formed for a course
  belongs_to :course
  belongs_to :assignment

  before_save :override_user_limit

  accepts_nested_attributes_for :group_memberships, :allow_destroy => true

  # Groups the user currently isn't in and are either not associated with a class or are associated with a class the user is in
  scope :suggested_for_user, lambda {|user| 
    mids = user.group_memberships.collect(&:id)
    cids = user.courses.collect(&:id)
    joins("INNER JOIN group_memberships ON (#{"group_memberships.id NOT IN (#{mids.join(',')}) AND " unless mids.empty?}groups.id  = group_memberships.id)").where("groups.course_id = ? OR groups.course_id IN (?)", nil, cids)
  }

  def leaders
    group_memberships.leaders.collect(&:user)
  end

  # Set the course through the assignment if the assignment is set
  def assignment=(a)
    course = a.course if a.course
  end

  def add_member(member, membership_opts={})
    return nil if member_exists? member
    raise GroupFullError if full?
    self.group_memberships.create!({:user => member, :status => 'active'}.merge(membership_opts))
    member_add_hook(member)
  end

  def full?
    user_limit > 0 and users.count == user_limit
  end

  def member_exists?(member)
    begin
      self.users.find(member.id)
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end

  #TODO: return value
  # options include
  #
  # * :count    - max number of possible meeting times wanted
  # * :duration - minimum duration of the meeting in minutes
  #
  # NOTE: for now it selects the best meeting time *for the day*, consider
  # later allowing multiple suggested meeting times per day
  # Returns an array of Availability instances
  #TODO: because it is limited to the day, it needs to collect all of them for the day and then select the best. the best is defined by the following criteria in order of precedence:
  #
  # 1. Number of members
  # 2. Number of leaders present
  # 3. Time of day (the earlier the better?)
  #NOTE: the above is not implemented and might not jive with availability
  def best_meeting_times(options={})
    count          = (options[:count] or default_meeting_times_count)
    duration       = (options[:duration] or default_meeting_times_duration)
    
    #bin availabilities by day of week
    dows = {}#days of week
    users.collect(&:availabilities).flatten.each do |availability| 
      dows[availability.day_of_week] ||= []
      dows[availability.day_of_week] << availability
    end

    ret = []

    dows.each do |day_number, avails|
      # Reject any where there isn't at least one other person who can meet
      dows[day_number].reject! {|avail| avails.find_all {|a| avail.overlaps_with?(a, duration)}.empty?}
      ret << Availability.common_overlap(dows[day_number])
    end

    ret.compact[0,count]
  end

private
  def default_meeting_times_count
    3
  end

  def default_meeting_times_duration
    0
  end

  def override_user_limit
    user_limit = assignment.user_limit if assignment and assignment.user_limit
  end

  # Sets up an appropriate link between the new member and all existing members
  def member_add_hook(member)
    link_type = LinkType.group_member
    self.users.each do |user|
      next if user == member
      Link.create!(
        :left_user => member, 
        :right_user => user, 
        :link_type => link_type,
        :context => self
      )
    end
  end
end
