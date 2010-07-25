Given /^I am "([^\s]+)"$/ do |email|
  @user = User.find_by_email(email)
end

Given %(my account is locked) do
  @user.lock_access!
end

Given %(my account is confirmed) do
  @user.confirm!
end

Given %(my account is not confirmed) do
  @user.update_attribute(:confirmed_at, nil)
end

Given %(I am not logged in) do
  Given %(I am on the log out page)
end

When /^I log in with password "(.*)"$/ do |password|
  Given %(I am on the log in page)
  When %(I fill in "Email" with "#{@user.email}")
  And %(I fill in "Password" with "#{password}")
  And %(I press "Sign in")
end
