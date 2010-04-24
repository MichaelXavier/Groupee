class AgendaItem < ActiveRecord::Base
  validates_presence_of :name, :meeting_id, :allow_nil => false

  belongs_to :meeting
end
