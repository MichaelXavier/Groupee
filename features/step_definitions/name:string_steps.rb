Given /^the following name:strings:$/ do |name:strings|
  Name:string.create!(name:strings.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) name:string$/ do |pos|
  visit name:strings_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following name:strings:$/ do |expected_name:strings_table|
  expected_name:strings_table.diff!(tableish('table tr', 'td,th'))
end
