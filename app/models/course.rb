class Course < ActiveRecord::Base
  validates_presence_of :sln, :title, :catalog_name, :quarter, :year, :allow_nil => false
  validates_numericality_of :year
  validates_uniqueness_of :sln
  validates_inclusion_of :quarter, :in => %w[ winter spring summer autumn ]

  has_and_belongs_to_many :students, :class_name => "Users"
  has_many :assignments, :dependent => :destroy
  has_many :links, :as => :context
  belongs_to :instructor
end
