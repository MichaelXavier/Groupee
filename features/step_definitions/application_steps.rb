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
