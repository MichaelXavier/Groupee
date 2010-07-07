Factory.sequence(:first_name) do
  Faker::Name.first_name
end

Factory.sequence(:last_name) do
  Faker::Name.last_name
end

Factory.sequence(:group_name) do
  Faker::Company.name
end

Factory.sequence(:studentid) do
  ret = ""
  7.times { ret += (0..9).to_a.rand.to_s }
  ret
end

Factory.sequence(:gender) do
  %w[m f].rand
end

Factory.sequence(:day_of_week) do
  (1..7).to_a.rand
end

Factory.sequence(:email) do
  Faker::Internet.email
end

Factory.define(:group_membership, :default_strategy => :build) do |m|
  m.leader false
  m.status 'active'

  m.association :group
  m.association :user
end

Factory.define(:leader_group_membership, :parent => :group_membership) do |m|
  m.leader true
end

Factory.define(:group, :default_strategy => :build) do |g|
  g.status  'active'
  g.name    { Factory.next(:group_name) }
  g.open    true
  g.user_limit 0
end

#FIXME: this factory does not build correctly
Factory.define(:small_group, :parent => :group) do |g|
  g.group_memberships do |group_memberships|
    [
      #FIXME: shouldn't have to do this but i can't seem to specify the
      #:factory => :leader_group_membership because it thinks im trying to use
      #an accessor factory=
      group_memberships.association(:group_membership, :leader => true),
      group_memberships.association(:group_membership),
      group_memberships.association(:group_membership),
    ]
  end
end

Factory.define(:availability, :default_strategy => :build) do |a|
  a.day_of_week { Factory.next(:day_of_week) }
  a.from        { 3.hours.ago }
  a.to          { 1.hour.from_now }
end

Factory.define(:user, :default_strategy => :build) do |u|
  u.first_name            { Factory.next(:first_name) }
  u.last_name             { Factory.next(:last_name) }
  u.studentid             { Factory.next(:studentid) }
  u.gender                { Factory.next(:gender) }
  u.email                 { Factory.next(:email) }
  u.password              "password"
  u.password_confirmation "password"
  u.confirmed_at Time.now
end

# User with only 1 day a week and one time available
Factory.define(:busy_user, :parent => :user) do |u|
  u.association :availabilities 
end

Factory.define(:group_leader, :parent => :user) do |u|
  #FIXME; not sure if you can use this on a has_many association
  u.association :group_memberships, :factory => :leader_group_membership
end

Factory.define(:assignment, :default_strategy => :build) do |a|
  a.name "Super Important Assignment"
  a.association :course
  a.assigned { 2.days.ago }
  a.due { 4.days.from_now }
  a.user_limit 0
end

Factory.define(:course, :default_strategy => :build) do |c|
  c.title "Bonus Bonanza" 
  c.sequence(:sln) {|n| n + 12345}
  c.catalog_name "CSS999" 
  c.quarter "winter" 
  c.year 2010
end

Factory.define(:meeting, :default_strategy => :build) do |m|
  m.title "Bonus Round" 
  m.from_date  2.hours.from_now
  m.to_date    4.hours.from_now
  m.location "Jungle Hijinx"
end

Factory.define(:agenda_item, :default_strategy => :build) do |a|
  a.name "Super important thing"
  a.description "Infiltrate Outer Heaven"
  a.association :meeting
  a.completed false
end

Factory.define(:instructor, :class => Instructor, :parent => :user) do |i|
end
