class UtilityPage

  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.goto "https://developer.here.com/documentation"
  end

  def navigate_link(api)
    @ang_ini_count = 0
    @status_code_count = 0
    @browser.label(:text, "#{api}").send_keys :enter

    doc_link_wrap  = @browser.div(xpath: './/*[@class="documentation-link-wrapper uk-margin-top "]')
    count_link_wrap  = doc_link_wrap.divs(:xpath, "//*[@class='documentation-link dp-anchor']").count
    (0..count_link_wrap-1).each do |link_1|
      doc_link_text = doc_link_wrap.divs(:xpath, "//*[@class='documentation-link-text']")[link_1].h5.text
      dp_link_anchor = doc_link_wrap.divs(:xpath, "//*[@class='documentation-link dp-anchor']")[link_1].links
      dp_link_anchor.each do |int_link|
        link_name = int_link.text
        p "---------------Navigating to #{api} -> #{doc_link_text} -> #{link_name} ----------------------------------------"
        int_link.send_keys :enter
        @browser.wait_until{|br| br.url.include?('.html')}
        response_code = page_status(@browser.url)
        val = check_angular_initialized
        if response_code[:code] == "200" && val == true
          puts "Response code for '#{api} -> #{doc_link_text} -> #{link_name}' status code is #{response_code[:code]} "
          puts "Angular is initialized for '#{api} -> #{doc_link_text} -> #{link_name}' link"
        else
          puts "Response code for '#{api} -> #{doc_link_text} -> #{link_name}' status code is NOT #{response_code[:code]} "
          puts "Angular is initialized for '#{api} -> #{doc_link_text} -> #{link_name}' link"
          @response_fail_link = "#{api} -> #{doc_link_text} -> #{link_name}"
          @status_code_count+= 1
          @ang_ini_count+=1
        end
          @browser.back
          @browser.wait_until{|br| br.window.title == 'Documentation, Code Examples and API References - HERE Developer'}
          print "\r\n"
      end
    end
    return @ang_ini_count, @status_code_count, @response_fail_link
  end

  #Purpose - Verify whether Angular is initialized when page loads
  def check_angular_initialized
    @browser.execute_script("return angular.element(document).injector().get('$http').pendingRequests.length === 0")
  end

  def check_pg_status
    page_status(@browser.url)
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
