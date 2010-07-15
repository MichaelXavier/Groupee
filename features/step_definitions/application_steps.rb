Given /^I have logged in as "([^\s]+)"$/ do |email|
  @user = Factory.create(:user, :email => email, :password => 'password')
  Given %(I am on the log in page)
  Given %(my account is confirmed)
  Given %(I log in with password "password")
   Then %(I should see "Signed in successfully")
end

Given %(I am an instructor) do
  @user.update_attributes(:type => 'Instructor')
end
