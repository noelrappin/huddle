Given /^a project named "(.*)"$/ do |project_name|
  @project = Project.create(:name => project_name)
end

Given /^the following users$/ do |user_data|
  user_data.hashes.each do |user_hash|
    User.create!(user_hash)
  end
end

Given /^that user "(.*)" is a member of the project$/ do |login|
  User.find_by_login(login).projects << @project
end

When /^I visit the edit page for the project$/ do
  visit("/projects/#{@project.id}/edit")
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label|
  field_labeled(label).should_not be_checked
end

When /^I check the box for user alpha$/ do
  pending
end

Then /^I should see (.*) checkboxes$/ do |checkbox_count|
  assert_select "input[type = checkbox][id *= user]", 
      :count => checkbox_count.to_i
end


Then /^I see "alpha@example\.com"$/ do
  pending
end

And /^I do not see "beta@example\.com"$/ do
  pending
end

Then /^I am taken to (.*)$/ do |path|
  assert(current_url.ends_with?(path_to(path)))
end

