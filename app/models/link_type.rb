class LinkType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :weight, 
                            :greater_than_or_equal_to => 0.0, 
                            :less_than_or_equal_to => 1.0,
                            :allow_nil => false

  has_many :links

  scope :group_members, lambda { where(:name => 'GroupMember').limit(1) }
  scope :classmates,    lambda { where(:name => 'Classmate').limit(1)   }

  def self.group_member
    self.group_members.first
  end

  def self.classmate
    self.classmates.first
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
  end
end
