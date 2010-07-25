Given /^existing Users? enrolled in course with sln (\d+):$/ do |sln, table|
  course = Course.find_by_sln(sln)
  table.hashes.each do |row|
    ivar = Factory.create(:user, correct_hash(row))
    course.add_student(ivar)
  end
end

Given /^existing Assignments in course with sln (\d+):$/ do |sln,table|
  course = Course.find_by_sln(sln)
  table.hashes.each do |row|
    ivar = Factory.create(:assignment, correct_hash(row).merge(:course => course))
  end
end

Given %(I teach the following courses:) do |table|
  table.hashes.each do |row|
    Factory.create(:course, correct_hash(row).merge(:instructor => @user))
  end
end
