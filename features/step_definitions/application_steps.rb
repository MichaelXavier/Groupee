Given /^I have logged in as instructor "([^\s]+)"$/ do |email|
  @user = Factory.create(:instructor, :email => email, :password => 'password')
  Given %(I am on the log in page)
  Given %(my account is confirmed)
  Given %(I log in with password "password")
   Then %(I should see "Signed in successfully")
end

Given /^I have logged in as "([^\s]+)"$/ do |email|
  @user = Factory.create(:user, :email => email, :password => 'password')
  Given %(I am on the log in page)
  Given %(my account is confirmed)
  Given %(I log in with password "password")
   Then %(I should see "Signed in successfully")
end

Given /^I should see an email link with "([^"]*)"(?: within "([^"]*)")?$/ do |email,selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :href => "mailto:#{email}")
    else
      assert page.has_xpath?('//*', :href => "mailto:#{email}")
    end
  end
end

When %(dump page) do
  puts "Dump of page body:"
  puts page.body
end

When %(debugger) do
  debugger;puts
end
