Given /^the following groups:$/ do |groups|
  Group.create!(groups.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) group$/ do |pos|
  visit groups_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following groups(?: within "([^"]*)")?:$/ do |selector, expected_groups_table|
  with_scope(selector) do
    expected_groups_table.diff!(tableish('table tr', 'td,th'))
  end
end

Given /^I am part of group (\d+)$/ do |gid|
  Group.find(gid).add_member(@user)
end

Given /^"([^"]+)" is part of group (\d+)$/ do |name,gid|
  first_name, last_name = name.split(' ', 2)
  user = User.find(:first, :conditions => {:first_name => first_name, :last_name => last_name})
  raise "Test error, user #{name} not found" unless user
  Group.find(gid).add_member(user)
end
