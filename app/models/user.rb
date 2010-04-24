class User < ActiveRecord::Base
  validates_uniqueness_of :studentid
  validates_inclusion_of :gender, :in => %w[ m f ]

  has_many :group_memberships
  has_many :groups, :through => :group_memberships
  has_many :availabilities
  has_and_belongs_to_many :course
end
