class Course < ActiveRecord::Base
  validates_presence_of :sln, :title, :catalog_name, :quarter, :year, :allow_nil => false
  validates_numericality_of :year
  validates_uniqueness_of :sln
  validates_inclusion_of :quarter, :in => %w[ winter spring summer autumn ]

  has_and_belongs_to_many :students, :class_name => "User"
  has_many :assignments, :dependent => :destroy
  has_many :links, :as => :context
  belongs_to :instructor

  def add_student(student)
    return nil if student_exists?(student)
    self.students << student
    student_add_hook(student)
    self.save
  end

  def student_exists?(student)
    begin
      self.students.find(student.id)
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end

private
  def student_add_hook(new_student)
    link_type = LinkType.classmate
    self.students.each do |student|
      next if student == new_student
      Link.create!(
        :left_user => new_student, 
        :right_user => student, 
        :link_type => link_type,
        :context => self
      )
    end
  end
end
