Given /^existing Users? enrolled in course with sln (\d+):$/ do |sln, table|
  course = Course.find_by_sln(sln)
  table.hashes.each do |row|
    ivar = Factory.create(:user, row)
    course.add_student(ivar)
  end
end

Given /^existing Assignments in course with sln (\d+):$/ do |sln,table|
  course = Course.find_by_sln(sln)
  table.hashes.each do |row|
    ivar = Factory.create(:assignment, row.merge(:course => course))
  end
end

Given %(I teach the following courses:) do |table|
  table.hashes.each do |row|
    Factory.create(:course, row.merge(:instructor => @user))
  end
end
