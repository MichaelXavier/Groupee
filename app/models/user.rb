class User < ActiveRecord::Base
  validates_uniqueness_of :studentid, :email
  validates_inclusion_of :gender, :in => %w[ m f ]
  validates_presence_of :first_name, :last_name, :email

  has_many :group_memberships
  has_many :groups, :through => :group_memberships
  has_many :availabilities
  has_and_belongs_to_many :course

  def full_name
    [self.first_name, self.last_name].join(" ")
  end
end
