User.find_or_create_by_email(
  :email => 'f.kong@funkysflights.com',
  :first_name => 'Funky',
  :last_name => 'Kong',
  :studentid => '11111',
  :gender => 'm'
)

# Standard Link Types
LinkType.find_or_create_by_name(
  :name => "GroupMember",
  :weight => 0.8
)

LinkType.find_or_create_by_name(
  :name => "Classmate",
  :weight => 0.4
)
