class GroupMembership < ActiveRecord::Base
  VALID_STATUSES = %w[ active suspended removed ]
  validates_inclusion_of :status,        :in => VALID_STATUSES
  validates_inclusion_of :leader, :in => [true,false]
  validates_presence_of :group_id, :allow_nil => false
  validates_presence_of :user_id,  :allow_nil => false

  belongs_to :group
  belongs_to :user

  scope :leaders, where("leader = ?", true)
end
