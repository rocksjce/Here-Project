Given(/^navigate to site$/) do
  @documentpage = UtilityPage.new(@browser)
  @documentpage.visit
end

When(/^navigate to internal links for Global APIs and SDKs (.*), (.*)$/) do |page_section, global_api_type|
  @documentpage.navigate_internal_links(page_section,global_api_type)
end

And(/^the page should load properly and return success status (.*)$/) do |status_code|
  response_code = @documentpage.page_status(@browser.url)
  expect(response_code).to include code: status_code
  logger.info "Page loaded successfully with status code #{status_code}"
end

When(/^navigate to internal links for China specific APIs and SDKs (.*), (.*)$/) do |page_section, global_api_type|
  @documentpage.select_radio_btn_china_api
  @documentpage.navigate_internal_links(page_section,global_api_type)
end

And(/^check angular is initialized when page loads$/) do
  angular_initialize = @documentpage.check_angular_initialized?
  expect(angular_initialize).to be true
  logger.info "Angular Initialization when page loads is #{angular_initialize}"
end

Then(/^verify success status of internal links and Angular initialization when page loads (.*), (.*), (.*)$/) do |global_api_type, link, status_code|
  links = link.split(",")
  links.each do |link_name|
    logger.info "Navigating to #{link_name.upcase} signal of global API type #{global_api_type}"
    angular_initialize, response_code = @documentpage.check_page_status(link_name)
    expect(angular_initialize).to be true
    logger.info "Angular Initialization when page loads is #{angular_initialize}"
    expect(response_code).to include code: status_code
    logger.info "#{link_name.upcase} link status is #{status_code}"
  end
end