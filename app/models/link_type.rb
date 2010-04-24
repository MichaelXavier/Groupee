class LinkType < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :weight, 
                            :greater_than_or_equal_to => 0.0, 
                            :less_than_or_equal_to => 1.0,
                            :allow_nil => false

  has_many :links
end
