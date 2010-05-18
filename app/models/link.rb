class Link < ActiveRecord::Base
  validates_presence_of :link_type_id, :left_user_id, :right_user_id 

  belongs_to :link_type
  belongs_to :left_user, :class_name => 'User'
  belongs_to :right_user, :class_name => 'User'
  belongs_to :context, :polymorphic => true

  scope :for_user, lambda {|user| where("left_user_id = ? OR right_user_id = ?", user.id, user.id) }
end
