Given(/^navigate to site$/) do
  @documentpage = UtilityPage.new(@browser)
  @documentpage.visit
end


When(/^navigate\|verify and check for Angular initialization for internal links of "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
  logger.info "Navigate to internal links of #{arg1}"
  @angular_initialize, @response_code, @response_fail_link = @documentpage.navigate_link(arg1)
  logger.info "Navigate to internal links of #{arg2}"
  @angular_initialize, @response_code, @response_fail_link = @documentpage.navigate_link(arg2)
end

Then(/^verify success status of internal links and Angular initialization when page loads$/) do
  expect(@angular_initialize).to eq(0)
  logger.info "Angular Initialization for API's when page loads are successful"
  expect(@response_code).to eq(0)
  logger.info "link status for API is success"
  expect(@response_fail_link.nil?).to be true
  if @response_fail_link.nil? == false
    @response_fail_link.each {|link_path| puts "Failed link path are #{link_path}"}
  end
end

And(/^the page should load properly and return success status$/) do
  pg_status = @documentpage.check_pg_status
  expect(pg_status).to include(code: '200')
  logger.info "Page loaded successfully"
end

Then(/^check angular is initialized when page loads$/) do
  ang_ini = @documentpage.check_angular_initialized
  expect(ang_ini).to be true
  logger.info "Angular is initialized when page loads"
end

