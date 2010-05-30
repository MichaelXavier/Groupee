namespace :demo do
  desc "Seed a bunch of test data for demonstrating SNA concepts" 
  task :setup, :needs => [:environment] do
    #FIXME: figure out how to get the test env without using the test db
    require 'faker'
    require 'factory_girl'
    require 'spec/factories'

    prog_msg("Creating LinkTypes") do
      LinkType.setup_defaults
    end

    prog_msg("Creating 3 instructors") do
      @instructors = []
      3.times { @instructors << Factory(:instructor) }
    end

    prog_msg("Creating 3 courses") do
      @assignments, @courses = [], []
      @instructors.each do |instructor|
        course = Factory.create(:course)
        3.times do
          assignment = Factory.create(:assignment)
          @assignments << assignment
          course.assignments << assignment
        end
        course.save!

        @courses << course
        instructor.courses << course
        instructor.save
      end
    end

    prog_msg("Setting up 20 groups") do
      @users = []
      20.times do
        group = Factory.build(:group)

        # Decide if it is a course group or not
        course_group = (rand(2) == 0)

        course = @courses[rand(@courses.length)]

        group.course = course if course_group

        group.save!

        rand(10).times do
          user = Factory.create(:user)
          @users << user
          group.add_member(user)

          if course_group
            course.add_student(user)
          end
        end
      end
    end

    prog_msg("Setting up 20 meetings") do
      20.times do
        meeting = Factory.create(:meeting)
        users = @users.dup
        rand(10).times do
          break if users.empty?
          user = users.delete_at(rand(users.length))
          meeting.add_attendee(user)

          # Optionally have them attend
          meeting.sign_in_attendee(user) if rand(2) == 0
        end
      end
    end

    puts <<-EOS
There are now #{Assignment.count} assignments
There are now #{Course.count} courses
There are now #{Group.count} groups
There are now #{GroupMembership.count} group memberships
There are now #{Instructor.count} instructors
There are now #{Link.count} links
There are now #{Meeting.count} meetings
There are now #{User.count} users
    EOS
  end

  #FIXME: refactor this somewhere so it can be shared?
private
  def prog_msg(msg, &blk)
    print "#{msg}..."
    blk.call
    puts "Done"
  end
end
