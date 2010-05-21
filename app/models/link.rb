class Link < ActiveRecord::Base
  validates_presence_of :link_type_id, :left_user_id, :right_user_id 

  belongs_to :link_type
  belongs_to :left_user, :class_name => 'User'
  belongs_to :right_user, :class_name => 'User'
  belongs_to :context, :polymorphic => true

  scope :for_user, lambda {|user| where("left_user_id = ? OR right_user_id = ?", user.id, user.id) }

  validate :disallow_self_join

private

  def disallow_self_join
    self.errors[:left_user_id] << "Cannot join a link node to itself." if self.left_user_id == self.right_user_id
  end
end
