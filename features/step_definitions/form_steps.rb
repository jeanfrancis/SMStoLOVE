When 'I fill in "$phone_number" as my phone number' do |phone_number|
  fill_in 'user[phone_number]', :with => phone_number
end

When 'I press the text me button' do
  click_button 'Text me'
end

When 'I press the sign up button' do
  click_button 'Text me'
end

When 'I fill in my secret code' do
  fill_in 'user[secret_code_confirmation]', :with => secret_code
end

When 'I fill in the secret code "$secret_code"' do |secret_code|
  fill_in 'user[secret_code_confirmation]', :with => secret_code
end

When 'I fill in my secret code in all caps' do
  fill_in 'user[secret_code_confirmation]', :with => secret_code.upcase
end

When 'I fill in "$secret_code" as my secret code' do |code|
  fill_in 'user[secret_code_confirmation]', :with => code
end

Then 'the secret code field is empty' do
  page.should_not =~ %r{<input.*id="user_secret_code_confirmation".*value=".+"}
end

When 'I fill in the date of birth with "$date_of_birth"' do |date_of_birth|
  date = Date.parse(date_of_birth)
  select date.year.to_s, :from =>'user_dob_1i'
  select Date::MONTHNAMES[date.month], :from =>'user_dob_2i'
  select date.day.to_s, :from =>'user_dob_3i'
end

When 'I fill in my name as "$name"' do |name|
  fill_in 'user[name]', :with => name
end

When 'I check my gender as male' do
  check 'user[male]'
end

When 'I check my gender as female' do
  check 'user[female]'
end

When 'I fill in the minimum age with "$min_age"' do |min_age|
  select min_age, :from => 'user[looking_for_minimum_age]'
end

When 'I fill in the maximum age with "$max_age"' do |max_age|
  select max_age, :from => 'user[looking_for_maximum_age]'
end

When 'I check my desired gender as female' do
  check 'user[looking_for_female]'
end

When 'I submit my profile' do
  click_button 'Get your account'
end

Then 'I see the error "$error_message" on the secret code field' do |error_message|
  within("#user_secret_code_confirmation_input") do
    page.should have_content(error_message), "expected secret code to have the error: #{error_message}"
  end
end

Then %r{I see the error "(.*)" on the following user fields?:} do |error_message, table|
  table.raw.flatten.each do |field|
    within("#user_#{field}_input") do
      page.should have_content(error_message), "expected #{field} to have the error: #{error_message}"
    end
  end
end

Then "I see that my gender can't be blank" do
  page.should have_content("must select at least one gender")
end

Then "I see that my desired gender can't be blank" do
  page.should have_content("must look for at least one gender")
end
