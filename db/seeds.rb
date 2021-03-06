# Create 2 users
@user1 = User.find_or_create_by_email(
  :email => 'f.kong@funkysflights.com',
  :first_name => 'Funky',
  :last_name => 'Kong',
  :studentid => '11111',
  :gender => 'm',
  :password => 'password',
  :password_confirmation => 'password'
)

@user2 = User.find_or_create_by_email(
  :email => 's.kong@bonusbonanza.com',
  :first_name => 'Swanky',
  :last_name => 'Kong',
  :studentid => '010101',
  :gender => 'm',
  :password => 'password',
  :password_confirmation => 'password'
)

[@user1, @user2].each(&:confirm!)

# Standard Link Types
LinkType.setup_defaults

# Create a few groups
@group = Group.find_or_create_by_name(
  :name => "King K. Rool Task Force",
  :user_limit => 2,
  :status => 'active',
  :website => 'http://www.dkc.com',
  :open => true
)

@group2 = Group.find_or_create_by_name(
  :name => "Cranky Kong's Cabin",
  :user_limit => 0,
  :status => 'active',
  :website => 'http://www.crankyscabin.com',
  :open => true
)

# Add group members
@group.add_member(@user1, :leader => true)
@group.add_member(@user2)

@group2.add_member(@user1, :leader => true)
@group2.add_member(@user2)

# Create an instructor
@instructor = Instructor.find_or_create_by_email(
  :email => "c.kong@dkc.com",
  :first_name => 'Candy',
  :last_name => 'Kong',
  :studentid => '22222',
  :gender => 'f'
)

# Create a course
@course = Course.find_or_create_by_sln(
  :sln => '12345',
  :year => 2010,
  :quarter => 'spring',
  :title => 'Social Computing',
  :catalog_name => 'CSS490A',
  :instructor => @instructor
)

# Create an Assignment
#TODO
