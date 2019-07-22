class UtilityPage

  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.goto "https://developer.here.com/documentation"
  end

  def navigate_internal_links(page_section, global_api_type)
    @browser.radio(:text, 'China specific APIs and SDKs').set?  ?  @pg_section = @browser.divs(:id, "#{page_section}")[1] : @pg_section = @browser.div(:id, "#{page_section}")
    #
    # else
    #   @pg_section = @browser.div(:id, "#{page_section}")
    # end
    case global_api_type
      when 'INTERACTIVE MAPS'
        @api_link = @pg_section.div(:id, 'maps')
      when 'MAP IMAGE'
        @api_link = @pg_section.div(:id, 'map_image')
      when 'MAP TILE'
        @api_link = @pg_section.div(:id, 'map_tile')
      when 'VENUE MAPS'
        @api_link = @pg_section.div(:id, 'venue_maps')
      when 'WEATHER'
        @api_link = @pg_section.div(:id, 'weather')
      when 'MAP FEEDBACK'
        @api_link = @pg_section.div(:id, 'map_feedback')
      when 'GEOSPATIAL DATA STORAGE & RENDERING WITH XYZ'
        @api_link = @pg_section.div(:id, 'xyz')
      when  'GEOCODING'
        @api_link = @pg_section.div(:id, 'geocoder')
      when  'GEOCODING AUTOCOMPLETE'
        @api_link = @pg_section.div(:id, 'geocoding_suggestions')
      when  'BATCH GEOCODING'
        @api_link = @pg_section.div(:id, 'batch_geocoder')
      when  'PLACES'
        @api_link = @pg_section.div(:id, 'places')
      when  'ROUTING'
        @api_link = @pg_section.div(:id, 'routing')
      when  'TRANSIT'
        @api_link = @pg_section.div(:id, 'public_transit')
      when  'INTERNALMODAL ROUTING'
        @api_link = @pg_section.div(:id, 'park_and_ride')
      when  'TRAFFIC'
        @api_link = @pg_section.div(:id, 'traffic')
      when 'FLEET TELEMATICS'
        @api_link = @pg_section.div(:id, 'fleet_telematics')
      when 'GEOFENCING'
        @api_link = @pg_section.div(:id, 'geofencing')
      when 'CUSTOM LOCATIONS'
        @api_link = @pg_section.div(:id, 'custom_location_extension')
      when 'CUSTOM ROUTES'
        @api_link = @pg_section.div(:id, 'custom_route_extension')
      when 'ADVANCED DATA SETS'
        @api_link = @pg_section.div(:id, 'platform_data_extension')
      when 'ROUTE MATCHING'
        @api_link = @pg_section.div(:id, 'route_match_extension')
      when 'TOLL COSTS'
        @api_link = @pg_section.div(:id, 'toll_cost_extension')
      when 'WAYPOINTS SEQUENCE'
        @api_link = @pg_section.div(:id, 'waypoints_secuence_extension')
      when 'FLEET CONNECTIVITY'
        @api_link = @pg_section.div(:id, 'fleet_connectivity_extension')
      when 'TRACKING'
        @api_link = @pg_section.div(:id, 'tracking')
      when 'POSITIONING'
        @api_link = @pg_section.div(:id, 'positioning')
      when 'Geovisualization'
        @api_link = @pg_section.div(:id, 'geovisualization')
      when 'On-Demand'
        @api_link = @pg_section.div(:id, 'on_demand')
      when 'Advertising Data Services'
        @api_link = @pg_section.div(:id, 'advertising_data_services')
    end
  end

  def check_page_status(link_name)
    @api_link.link(:text, "#{link_name}").wait_until(timeout: 120, &:present?).send_keys :enter
    @browser.wait_until{|br| br.url.include?(".html")}
    puts "                                       INFO -- : #{link_name.upcase} link is visible"
    angular_initialization = check_angular_initialized?
    status_code = page_status(@browser.url)
    @browser.execute_script('window.history.back();')   # Move to previous page
    @browser.wait_until{|br| br.window.title == "Documentation, Code Examples and API References - HERE Developer"}
    return angular_initialization, status_code
  end

  #Purpose - Verify whether Angular is initialized when page loads
  def check_angular_initialized?
    @browser.execute_script("return angular.element(document).injector().get('$http').pendingRequests.length === 0")
  end

  #Purpose - Choose radio button of China API
  def select_radio_btn_china_api
    @browser.label(:text, 'China specific APIs and SDKs').wait_until(timeout: 60, &:present?).click!
  end

  #Purpose - Check status of the URL
  def page_status url
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    if url.scheme.downcase == "https"
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
    end
    http.start do
      http.request_get(url.path.empty? ? "/" : url.path) do |res|
        return {:name => res.class, :code => res.code}
      end
    end
  end

end
