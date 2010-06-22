class AgendaItem < ActiveRecord::Base
  validates_presence_of :name, :meeting_id, :allow_nil => false

  belongs_to :meeting

  def mark_completed
    self.update_attributes(:completed => true)
  end
end
